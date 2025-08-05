#!/bin/bash

# Exit on error
set -e

echo "Creating Rails + UnoCSS + optional Svelte project..."

# Create new Rails app
rails new $1 --skip-javascript
cd $1

# Set up frontend folder
mkdir frontend
cd frontend

# Initialize npm and install dependencies
npm init -y
npm install vite unocss svelte @sveltejs/vite-plugin-svelte

# Create config files
cat > uno.config.ts <<EOF
import { defineConfig, presetUno } from 'unocss'
export default defineConfig({
  presets: [presetUno()],
  content: {
    pipeline: {
      include: ['../app/views/**/*.html.erb', './svelte/**/*.svelte'],
    },
  },
})
EOF

cat > vite.config.js <<EOF
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
EOF

cat > main.js <<EOF
import 'uno.css'
// Add optional Svelte mounting logic here
EOF

# Add scripts to package.json
npx json -I -f package.json -e 'this.scripts={dev:"vite",build:"vite build"}'

echo "✅ Rails + UnoCSS + Svelte project scaffolded in $1"
