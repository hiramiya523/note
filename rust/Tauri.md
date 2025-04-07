
# Svelte + Tauri + bun

前提として、Visual Studio のビルドツールのインストールが必要。

bun x create-tauri-app

```ps1
PS C:\Users\sirakawa> bun x create-tauri-app
✔ Project name · nu-project
✔ Identifier · com.nu-project.app
✔ Choose which language to use for your frontend · TypeScript / JavaScript - (pnpm, yarn, npm, deno, bun)
✔ Choose your package manager · bun
✔ Choose your UI template · Svelte - (https://svelte.dev/)
✔ Choose your UI flavor · TypeScript

Template created!

Your system is missing dependencies (or they do not exist in $PATH):
╭─────┬───────────────────────╮
│ Bun │ Visit https://bun.sh/ │
╰─────┴───────────────────────╯

Make sure you have installed the prerequisites for your OS: https://tauri.app/start/prerequisites/, then run:
  cd nu-project
  bun install
  bun run tauri android init

For Desktop development, run:
  bun run tauri dev

For Android development, run:
  bun run tauri android dev
```

