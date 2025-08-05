# Hugo + UnoCSS + (Optional) Svelte Starter

A minimal setup for building fast, pre-rendered static websites with Hugo, using UnoCSS for styling and optional Svelte components for interactivity.

---

## 🧰 Stack Overview

- **Hugo** for SSG
- **UnoCSS** for on-demand utility CSS
- **Svelte** (optional) for JS components
- **Vite** to bundle JS/CSS (optional but recommended)

---

## 📁 Project Structure

```
hugo-site/
├── content/
├── layouts/
│   └── _default/
│       └── baseof.html          # load uno.css and main.js here
├── static/                      # Built JS/CSS goes here
│   └── js/
│   └── css/
├── assets/                      # Optional Hugo asset pipeline
├── frontend/                    # UnoCSS + Svelte
│   ├── uno.config.ts
│   ├── svelte/
│   ├── main.js
│   └── vite.config.js
├── package.json
└── config.toml
```

---

## 🧪 Setup Guide

### 1. Install Hugo

Follow the instructions at: https://gohugo.io/getting-started/installing/

---

### 2. Initialize Hugo Site

```bash
hugo new site hugo-site
cd hugo-site
```

---

### 3. Setup Node Project & Install Dependencies

```bash
mkdir frontend
cd frontend
npm init -y
npm install unocss vite svelte @sveltejs/vite-plugin-svelte
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
      include: ['../layouts/**/*.html', '../content/**/*.md', './**/*.svelte'],
    },
  },
})
```

---

### 5. Vite Configuration

`frontend/vite.config.js`:

```js
import { defineConfig } from 'vite'
import Unocss from 'unocss/vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'

export default defineConfig({
  root: './',
  build: {
    outDir: '../static',
    emptyOutDir: true,
  },
  plugins: [svelte(), Unocss()],
})
```

---

### 6. Main JS Entry (Optional)

`frontend/main.js`:

```js
import 'uno.css'
// Add optional Svelte mounting here if needed
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

### 8. Add References in Hugo Layout

In `layouts/_default/baseof.html`:

```html
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="/uno.css">
</head>
<body>
  {{ block "main" . }}{{ end }}
  <script defer src="/main.js"></script>
</body>
</html>
```

---

### 9. Build and Serve

```bash
cd frontend
npm run build
cd ..
hugo serve
```

---

## ✅ Done

You now have a Hugo site with on-demand CSS and optional JS component rendering.
