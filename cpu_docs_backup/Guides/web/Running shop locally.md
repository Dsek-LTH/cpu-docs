# Running shop locally

To test the shop, very little needs to be done. You can create tickets and even get free tickets to try non-payment flows. If you want to try out payments, you have to do a little set-up to get it to work at all, and a little bit more work to get the workflow to work in its entirety.\n

### Setup environment variables

In  `.env.local` add the following keys. Below are not the real keys, they can be retrieved from the Stripe account or asking someone in CPU. 

**Make sure to use test keys and not prod keys.**  Test keys are marked with `_test_`

```javascript
PUBLIC_STRIPE_KEY=pk_test_...
SECRET_STRIPE_KEY=sk_test_...
```


### Test payment methods (and even cause specific errors, such as missing funds)

See <https://docs.stripe.com/testing> for test cards, an easy one is `4242 4242 4242 4242`, any valid expiry date and any three-digit code as CVC. On the page listed there are a bunch of cards which results in specific errors.


### Create ticket

It's very simple, first you need an event — remember its' name — and then go to shop → tickets. Once there, search for you event name, and fill out the form. Make sure to change the "release date" to a date in the past, by default it's tomorrow at 12.15


## Running webhooks locally

Stripe is event driven. The client does the purchase and when it succeeds/fail or whatever Stripe tells ut via webhooks, AKA they send a request to a previously defined endpoint. For production this is done towards `www.dsek.se/api/stripe/webhook`, for `_test_` keys it sends to `sandbox.dsek.se` (I think), but you can also change it so they are instead sent to your local computer (amazing right?!)


If you do not need webhooks, I believe it still works because the server will periodically fetch information from stripe, but if you want the "seamless flow" we are used to when purchasing tickets on dsek.se, you need to set up webhooks locally.


See <https://docs.stripe.com/webhooks> for Stripe's guide. You need to also add the following to your `.env.local`, again see the stripe account or ask a dev.

```javascript
SECRET_STRIPE_WEBHOOK_SIGNING=whsec_...
```