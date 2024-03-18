# Gitlab
ブランチ運用をしてみる

- ブランチ作成まで
  確認
  git branch

ローカルに作成
  git branch hotfix-username-hoge-fuga

確認
  git branch

作成したブランチに移動
  git switch hotfix-username-hoge-fuga

※ checkout より、switchを推奨
  ブランチ切替以外にも、変更の取り消しなども含まれていたので、危ないかも。
  ⇒ 確認: 変更を引き継いでいるように思える。

- リモートにローカル作成のブランチを作成
 git push origin hotfix-username-hoge-fuga


# 作業ブランチに、mainの変更を反映
  
  git checkout main 

  - 最新に
     git pull
  - 取込
    git checkout work-branch
    git merge main
