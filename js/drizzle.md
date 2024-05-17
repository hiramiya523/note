# setup
bun add drizzle-orm postgres
bun add -D drizzle-kit

- studio使いたいなら
  bun add -D pg

# config
プロジェクトルートにconfig作る。
📦 <project root>
 ├ ...
 ├ 📂 drizzle
 ├ 📂 src
 ├ 📜 drizzle.config.ts
 └ 📜 package.json

Drizzle Kit lets you declare configurations in TypeScript, JavaScript or JSON configuration files.
jsでもtsでもjsonでもいいよー

```ts
import type { Config } from "drizzle-kit";
export default {
  schema: "./src/schema.ts",

  // drizzle by default
  out: "./drizzle",

//   mysql2, better-sqlite, libsql, turso
driver: "pg",

// connectionString: "postgresql://postgres:password@host:port/db",
// --uri=postgresql://user:pass@host:port/db_name

} satisfies Config;
```

- 実際のDBから、スキーマ生成クエリを生成
  bunx drizzle-kit introspect:pg

- ts/js ファイルで定義した、マイグレーションを実行
  bunx drizzle-kit push:pg

- studio
  bunx drizzle-kit studio --host 0.0.0.0 --port 3000


実行時、pgを入れてくれって言われた
  ```
  error please install required packages: 'pg'
  ```
⇒ vpsだと厳しいかも.つなぎ方が特殊。