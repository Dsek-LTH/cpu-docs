# web

This page contains links to tutorials for technologies used in the [Dsek-LTH/web](https://github.com/Dsek-LTH/web) repo.

# HTML

HTML defines the meaning and structure of web content.


::: tip Tutorial
Learn HTML at [Codecademy](https://www.codecademy.com/learn/learn-html).

:::

### HTML example

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Page title</title>
  </head>
  <body>
    <h1>This is a heading</h1>
    <p>This is a paragraph.</p>
  </body>
</html>
```


---

# CSS

CSS is a way to change the look of HTML web pages.


::: tip Tutorial
Learn CSS at [Codecademy](https://www.codecademy.com/learn/learn-css).

:::

### CSS example

```css
body {
  background-color: lightblue;
}

h1 {
  color: white;
  text-align: center;
}

p {
  font-family: verdana;
  font-size: 20px;
}
```

### Tailwind CSS

Tailwind CSS is a CSS framework that provides utility classes that are used to apply styles rapidly. We do not provide any tutorial, but there are helpful [cheatsheets](https://nerdcave.com/tailwind-cheat-sheet) available that lists all the utility classes available in Tailwind.

#### Tailwind example

```markup
<!-- HTML -->
<button
  class="flex items-center bg-blue-500 px-4 py-3 text-white hover:bg-blue-400"
/>
  Click me!
</button>
```

```css
/* CSS - automatically generated from the Tailwind classes used in the HTML */
.flex {
  display: flex;
}

.items-center {
  align-items: center;
}

.bg-blue-500 {
  --tw-bg-opacity: 1;
  background-color: rgb(59 130 246 / var(--tw-bg-opacity));
}

.px-4 {
  padding-left: 1rem;
  padding-right: 1rem;
}

.py-3 {
  padding-top: 0.75rem;
  padding-bottom: 0.75rem;
}

.text-white {
  --tw-text-opacity: 1;
  color: rgb(255 255 255 / var(--tw-text-opacity));
}

.hover\:bg-blue-400:hover {
  --tw-bg-opacity: 1;
  background-color: rgb(96 165 250 / var(--tw-bg-opacity));
}
```


---

# JavaScript

JavaScript is a programming language that is used to make web pages interactive.


::: tip Tutorial
Learn JavaScript at [Codecademy](https://www.codecademy.com/learn/introduction-to-javascript).

:::

### JavaScript example

```javascript
const inputElement = document.querySelector("input");
const buttonElement = document.querySelector("button");
const listElement = document.querySelector("ul");

buttonElement.addEventListener("click", () => {
  const text = inputElement.value;
  const listItemElement = document.createElement("li");
  listItemElement.textContent = text;
  listElement.appendChild(listItemElement);
  inputElement.value = "";
});
```


---

# TypeScript

TypeScript is a superset of JavaScript that adds static types to the language.


::: tip Tutorial
Learn TypeScript at [Codecademy](https://www.codecademy.com/learn/learn-typescript).

:::

### TypeScript example

```typescript
interface User {
  id: number;
  firstName: string;
  lastName: string;
  role: string;
}

function updateUser(id: number, update: Partial<User>) {
  const user = getUser(id);
  const newUser = { ...user, ...update };
  saveUser(id, newUser);
}
```


---

# Svelte

Svelte is a component framework used to build more advanced web applications.


::: tip Tutorial
Learn Svelte at [svelte.dev/tutorial](https://svelte.dev/tutorial).

:::

### Svelte example

```markup
<script lang="ts">
  const name = "world";
  let count = $state(0);

  function handleClick() {
    count += 1;
  }
</script>

<h1>Hello {name}!</h1>

<button onclick={handleClick}>
  Clicked {count}
  {#if count === 1}
    time
  {:else}
    times
  {/if}
</button>
```


---

# SvelteKit

SvelteKit is an application framework for Svelte that provides routing, server-side rendering, data fetching, and more.


::: tip Tutorial
Learn SvelteKit at [svelte.dev/tutorial/kit](https://svelte.dev/tutorial/kit).

:::

### SvelteKit example

```markup
<!-- +page.svelte -->
<script lang="ts">
  export let data;
</script>

<p>{data.message}</p>
```

```typescript
// +page.server.ts
export const load = async () => {
  return { message: "Hello, world!" };
};
```

```markup
<!-- app.html -->

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <link rel="icon" href="%sveltekit.assets%/favicon.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    %sveltekit.head%
  </head>
  <body data-sveltekit-preload-data="hover">
    <div style="display: contents">%sveltekit.body%</div>
  </body>
</html>
```


---

# Prisma

Prisma is a database ORM that makes it easy to work with databases in a type-safe manner.


::: tip Tutorial
Learn Prisma at [Prisma](https://www.prisma.io/docs/getting-started/quickstart).

:::

### Prisma example

```typescript
// schema.prisma
model User {
  id    Int     @id @default(autoincrement())
  name  String
  email String  @unique
  posts Post[]
}

model Post {
  id        Int     @id @default(autoincrement())
  title     String
  content   String?
}
```

```typescript
// index.ts
const prisma = new PrismaClient();
await prisma.user.create({
  data: {
    name: "Alice",
    email: "alice@example.com",
    posts: {
      create: { title: "Hello, World!" },
    },
  },
});
```


---

# ZenStack

ZenStack is a toolkit built on top of Prisma that adds an access control layer, an auto-generated API, and more.


::: tip Tutorial
Learn ZenStack at [ZenStack](https://zenstack.dev/docs/the-complete-guide/).

:::

### ZenStack example

```typescript
// schema.zmodel
model User {
  id    Int     @id @default(autoincrement())
  name  String
  email String  @unique

  // everybody can signup
  @@allow("create,read", true)

  // full access by self
  @@allow("all", auth() == this)

  // deny delete for all
  @@deny("delete", true)
}
```

```typescript
// index.ts
export const prismaClient = new PrismaClient();
const prisma = enhance(prismaClient, user);
await prisma.user.create({
  data: {
    name: "Alice",
    email: "alice@example.com",
  },
});

// throws error: ACCESS_POLICY_VIOLATION
await prisma.user.delete({
  where: { name: "Alice" },
});
```


---

# Git

Git is a version control system that allows you to track changes in your code and collaborate with others.


::: tip Tutorial
Learn Git at [Codecademy](https://www.codecademy.com/learn/learn-git).

:::

### Git example

```bash
git switch -c new-feature
git add .
git commit -m "Add new feature"
git push origin new-feature
```