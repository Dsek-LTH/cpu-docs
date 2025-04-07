# Shop system

# Overview

## Core Entities

```yaml
Shoppable:
  type: ShoppableType
  author: Member
  price: Int
  availability: { from: DateTime, to: DateTime? }
  questions: ItemQuestion[]
  accessPolicies: (role | member)[]

Ticket:
  shoppable: Shoppable
  event: Event
  stock: Int
  maxPerUser: Int

ItemQuestion:
  shoppable: Shoppable
  type: String # "choice", "free-text", etc.
  options: ({ answer: String, extraPrice: Int? })[]

Consumable:
  shoppable: Shoppable
  owner: Member | GuestBuyer
  purchasedAt: DateTime?
  priceAtPurchase: Int?
  consumedAt: DateTime?
  questionResponses: ItemQuestionResponse[]

ConsumableReservation:
  shoppable: Shoppable
  owner: Member | GuestBuyer
  order: Int?
```

Abstracted UML (not representative of all actual keys, see live schema in codebase)

UML: [https://media.discordapp.net/attachments/552503909302796300/1338584463998980217/image.png?ex=67ab9d6d&is=67aa4bed&hm=57194f8c9022dff1ded4f861dddb76dbf08b17b4cc60bd94eb9db75ef034723c&=&format=webp&quality=lossless&width=2268&height=1198](https://media.discordapp.net/attachments/552503909302796300/1338584463998980217/image.png?ex=67ab9d6d&is=67aa4bed&hm=57194f8c9022dff1ded4f861dddb76dbf08b17b4cc60bd94eb9db75ef034723c&=&format=webp&quality=lossless&width=2268&height=1198)


## Base workflow


1. Ticket is created
2. User presses "add to cart" *it may say other things, such as enter lottery*

   
   1. If ticket was released < 5 minutes ago, enter user into lottery
   2. Else, check constraints such as ticket being sold out, and throw error in that case
   3. Else, if ticket is free → add to user's inventory immidiately
   4. Else, add to user's cart
3. (Only run once) 5 minutes after ticket was released

   
   1. If number of people in lottery <= number of tickets → Move all lottery entries (`ConsumableReservations`) into cart (`Consumable`)
   2. Else, randomly shuffle the list of entires, move the top **n** (where **n** = ticket stock) into cart. Put the rest in "queue" by saving their order in queue in the database
4. (When in cart) User has 5 minutes to answer any potential questions and pay

   
   1. After 5 minutes, expire consumable. It checks if there are any reservations in queue

      
      1. Move top reservation to cart
      2. Decrease "order" on rest
5. (After payment, backend) Stripe validates payment, upon response will send request to our servers and also move user's client to /shop/success page

   
   1. On payment error, user will have 5 more minutes to finish payment
6. (Success page) Wait until D-sek backend agrees payment did succeed. Go to inventory
7. (Inventory) Shows user's tickets 


# Technical deep-dive

This is in no way extensive and the best way to understand the payment system is to read the code. But that's quite difficult. This section is meant to help you navigate the code base. I recommend using `Cmd/Ctrl+P` in VS Code (you may have rebound it, `Go to file...`) to navigate, and/or search for symbols (`Cmd/Ctrl+T`).


`addToCart.ts -> addTicketToCart(...)`: Entry point, called when user pressed "add to cart"/"enter lottery"/"get" on `/shop/tickets`.  This handles errors and constraints, and handles step 2 above. If it's the first call in the reservation window, a `setTimeout` is called which ends after the 5 minute reservation window. Afterwards it calls \``performLotteryIfNecessary`


`reservations.ts -> performLotteryIfNecessary(...)` checks if 5 minutes have passed, and then performs lottery.  Does the logic mentioned earlier.


`reservations.ts -> removeExpiredConsumables(...)` Removes all consumables which have expired after the 5 minutes. Also queues a setTimeout call to call itself recursively. The time to wait is based upon when the next consumable in the database should expire.\n

`reservations.ts -> ensureState(...)` Calls the above two methods. This method ensures a constraint-valid database state, it can be called multiple times without a problem. It HAS to be called in a transaction. The two methods can lead to actions which sends a notification, but since it's done in a transaction which may be aborted, it cannot send the notification immidiately. Thus it returns a list of queuedNotifications. **You as the caller** are responsible for sending notifications afterwards, see `sendQueuedNotifications` and `withHandledNotificationQueue`. 


`purchase.ts -> purchaseCart(…)` prepares the purchase, but does no monetary transaction in itself. Checks constraint, asks stripe in case payment has already been made, calculates actual price. Then it prepares a stripe payment intent (see <https://docs.stripe.com/api/payment_intents>), updates database to mark consumables as in-purchase (they will not expire, and for fault handling), and then returns the intent client secret to the frontend.


This is sent to `SveltePaymentElement.svelte`, which handles everything frontend-wise. Then stripe sends a webhook to `/stripe/webhooks/+server.ts`, this marks everything as purchased or not. It also handles edge cases where there's been a disconnection between the intent and the consumables, it will try to find the consumables with the intent metadata for example.


User is redirected to `/shop/success`, where the load function checks if the payment went through. (See `paymentCallback.ts -> stripeCallbackLoad`) In that case, redirect to inventory. Otherwise, display loading screen with information, and keep busy polling.