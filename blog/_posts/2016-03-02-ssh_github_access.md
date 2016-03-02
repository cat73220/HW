---
title:  "SSH github access"
layout: post
categories: [larning, github.com]
---

### github.comにユーザ名／パスワードを入力せずにpush/pullする

#### 自分のPCの準備

1. ``ssh_keygen``で``id_rsa/id_rsa.pub``を作成する
  - 後の手動入力をなくすためにパスフレーズは何も入力せずただ<enter>を入力する
  - ``<home>/.ssh``に生成される
1. ``<home>/.ssh``で``ssh_add id_rsa``を実行して``<home>/.ssh/known_hosts``を更新する
1. ``<home>/.ssh/id_rsa.pub``をクリップボードにコピーしておく

#### github.comの自分のアカウントの準備

1. github.comの自身のフロントページ右上端の'Edit Profile'を選んで'Public Profile'ページに移動する
1. 'Public Profile'ページの左側ペーンの'SSH Keys'を選んで'SSH Keys'ページに移動する
1. 'SSH Keys'ページ右上端の'New SSH Key'を選んでこのページをSSH鍵追加状態にする
1. 'Title'に任意の文言を入力する。
  - 後でこの鍵がどこのどのPCで生成したか特定できるようにしておくと良い
1. 先の'自分のPCの準備'でクリップボードにコピーした<home>/.ssh/id_rsa.pubを'Key'欄にペーストする
1. 'Add SSH Key'ボタンを押す

#### 確認

1. 作業PCのshell端末で``ssh git@github.com``を実行し下記のメッセージ①を得る
  - WarningとPTYで始まる行は無視して'Hi cat73220!..'からの行に着目する。ログイン承認できたけどshellアクセスを提供していません。切断します。ということ。
1. クローンしたローカルリポジトリのremoteを変更する
  - git remote set-url origin git@github.com:cat73220/cat73220.github.io.git
  - git remote -v
  - 下の``git remote -vの結果``が得られる
1. ファイルをどれか修正・コミットして'git push origin master'して、ユーザー／パスワードが尋ねられないことを確認する

- メッセージ①

~~~ shell
  Warning: Permanently added the RSA host key for IP address '192.30.252.128' to the list of known hosts.
  PTY allocation request failed on channel 0
  Hi cat73220! You've successfully authenticated, but GitHub does not provide shell access.
  Connection to github.com closed.
~~~

- git remote -vの結果

~~~ shell
origin	git@github.com:cat73220/cat73220.github.io.git (fetch)
origin	git@github.com:cat73220/cat73220.github.io.git (push)
~~~
