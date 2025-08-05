#!/bin/bash

# Exit on error
set -e

echo "Creating Hugo + UnoCSS + optional Svelte project..."

# Create new Hugo site
hugo new site $1
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
      include: ['../layouts/**/*.html', '../content/**/*.md', './**/*.svelte'],
    },
  },
})
EOF

cat > vite.config.js <<EOF
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
EOF

cat > main.js <<EOF
import 'uno.css'
// Add optional Svelte mounting logic here
EOF

# Add scripts to package.json
npx json -I -f package.json -e 'this.scripts={dev:"vite",build:"vite build"}'

echo "✅ Hugo + UnoCSS + Svelte project scaffolded in $1"
