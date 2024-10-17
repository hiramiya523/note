# Overview

このノートは、汎用的に使えるAPIについての設計や、
問題点、開発の知見等をまとめたものです。

This note complies the design, issuees, and development insights regarding general-purpose APIs.

- compiles: コンパイルじゃないよｗ
まとめる、扱うという動詞。

- aboutではなくregardingなのは、
内容が技術的でフォーマルだからだとｗ

## Design

### Get

Use URL GET parameters in the following cases:

- Filter conditions
- Sort conditions
- Data segmentaion.

「URL GET parameters」のような技術用語や一般的な概念については、特に冠詞をつけなくても問題ありません

More general criteria are as follows.

- It is an optional parameter.
- It has no side effects.

### Knowledge gained during developement

When in doubt, decide from perspective scheme design.