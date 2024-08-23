# add to sveltekit project
https://www.shadcn-svelte.com/docs/installation/sveltekit

1. tailwind
  pnpm dlx @svelte-add/tailwindcss@latest
2. pnpm install

3. Configure components.json
  pnpm dlx shadcn-svelte@latest init
  ```
  node@19bc1fa63e03:~/front$ pnpm dlx @svelte-add/tailwindcss@latest
    .../190c63ffa3a-45                       |  WARN  deprecated @svelte-add/tailwindcss@1.0.17
    Packages: +4
    ++++
    Progress: resolved 4, reused 0, downloaded 4, added 4, done
    @svelte-add/tailwindcss version 1.0.17

    ┌  Welcome to Svelte Add!
    │
    ◇  Do you want to use typography plugin?
    │  No
    │
    ◇  Successfully installed dependencies
    │
    ┌   shadcn-svelte  v0.10.7 
    │
    ◇  Would you like to use TypeScript? (recommended)
    │  Yes
    │
    ◇  Which style would you like to use?
    │  Default
    │
    ◇  Which base color would you like to use?
    │  Slate
    │
    ◇  Where is your global CSS file? (this file will be overwritten)
    │  src/app.css
    │
    ◇  Where is your Tailwind config located? (this file will be overwritten)
    │  tailwind.config.ts
    │
    ◇  Configure the import alias for components:
    │  $lib/components
    │
    ◇  Configure the import alias for utils:
    │  $lib/utils
    │
    ◇  Config file components.json created
    │
    ◇  Project initialized
    │
    ◇  Dependencies installed
    │
    └  Success! Project initialization completed.
    ```
1. pnpm dlx shadcn-svelte@latest add button