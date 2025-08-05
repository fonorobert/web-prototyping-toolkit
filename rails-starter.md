# Rails + UnoCSS + (Optional) Svelte Starter

A minimal setup for building server-rendered or API-based Rails apps using UnoCSS for styling and optional Svelte for frontend interactivity.

---

## 🧰 Stack Overview

- **Ruby on Rails** (with or without views)
- **UnoCSS** for minimal CSS, only what's used
- **Svelte** (optional) for component interactivity
- **Vite** to bundle JS/CSS

---

## 📁 Project Structure

```
rails-app/
├── app/
│   ├── assets/
│   │   ├── stylesheets/
│   │   └── javascripts/
│   │       ├── components/      # Optional Svelte
│   │       └── main.js
│   ├── views/
├── frontend/
│   ├── uno.config.ts
│   ├── svelte/
│   ├── main.js
│   └── vite.config.js
├── public/                      # JS/CSS output
├── package.json
└── config/
```

---

## 🧪 Setup Guide

### 1. Install Rails

```bash
gem install rails
```

---

### 2. Create Rails App (Skip JS)

```bash
rails new rails-app --skip-javascript
cd rails-app
```

---

### 3. Set Up Frontend Environment

```bash
mkdir frontend
cd frontend
npm init -y
npm install vite svelte unocss @sveltejs/vite-plugin-svelte
```

---

### 4. UnoCSS Configuration

`frontend/uno.config.ts`:

```ts
import { defineConfig, presetUno } from 'unocss'
export default defineConfig({
  presets: [presetUno()],
  content: {
    pipeline: {
      include: ['../app/views/**/*.html.erb', './svelte/**/*.svelte'],
    },
  },
})
```

---

### 5. Vite Configuration

`frontend/vite.config.js`:

```js
import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'
import Unocss from 'unocss/vite'

export default defineConfig({
  root: './',
  build: {
    outDir: '../public',
    emptyOutDir: true,
  },
  plugins: [svelte(), Unocss()],
})
```

---

### 6. Main JS Entry

`frontend/main.js`:

```js
import 'uno.css'
// Add Svelte mount logic here (optional)
```

---

### 7. package.json Scripts

```json
"scripts": {
  "dev": "vite",
  "build": "vite build"
}
```

---

### 8. Reference Assets in Rails Layout

In `app/views/layouts/application.html.erb`:

```erb
<%= stylesheet_link_tag 'uno.css', media: 'all' %>
<%= javascript_include_tag 'main.js', defer: true %>
```

---

### 9. Build Frontend

```bash
cd frontend
npm run build
```

---

## ✅ Done

Rails will now serve your minimal CSS and optional compiled JS for any interactive components.
