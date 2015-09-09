---
layout: post
title: "Reminder for installing ruby and bundler"
date: 2015-09-09 16:33:00
categories: Learning
---

Ubuntuでsudoとapt-getを使わずに、ローカルユーザディレクトリにrubyをインストールする方法を示します。

rbenvというrubyシステムインストーラを使い、その後にbundlerをインストールします。

rbenvのインストール
----

### 準備


    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

最後の`apt-get install`の実行前に

    dpkg -l | grep "autoconf\|bison\|build-essential\|libssl-dev\|libyaml-dev\|libreadline6-dev\|zlib1g-dev\|libncurses5-dev\|libffi-dev\|libgdbm3\|libgdm-dev\|nodejs\|libsqlite3-dev"

のように`dpkg -l | grep "..."`を実行して既にインストールされているubuntuパッケージの一覧を得て、まだされていないubuntuパッケージを調べて、`sudo apt-get install -y `にそれらのパッケージを与えて実行します。

### 実行できるようにする


 .bashrcに下記シェルスクリプトを追加します。

    [[ -d ~/.rbenv  ]] && \
        export PATH=${HOME}/.rbenv/bin:${PATH} && \
		eval "$(rbenv init -")

`~/.rbenv`ディレクトリの存在確認を検査し存在した場合`PATH`シェル環境変数に`~/.rbenv/bin`を追加、および`rbenv init -`を実行します。

### rubyのインストール

いよいよ`rbenv`で`ruby`をインストールします。

    rbenv install 2.2.2
	rbenv global 2.2.2
	ruby -v

最初の`rbenv install`によりソースコードがダウンロードされビルド、そして、インストールされます。インストール先は~/.rbenv配下のディレクトリでインストール完了時に詳細が出力されますので確認してください。尚この操作はPCの性能に左右されます。Core-i7 3960Xで3分ほどかかりました。

次の`rbenv global`でインストールしてあるバージョンを選びます。つまり、複数バージョンの`ruby`を切り替えて利用できるのです。今回は2.2.2を使いたいので`2.2.2`を与えました。

最後の`ruby -v`で実行PATH上の`ruby`のバージョンを確認します。

bundlerのインストール
----

`ruby`のインストールが済んでしまえば`gem`コマンドを使うだけなので簡単です。

	gem install bundler

これで使えるようになります。

Gemfilesがあるディレクトリに移動して

	bundle install

を実行すればそのGemfilesに記述してある`RubyGem`を`bundler`がインストールしてくれます。インストール先は`rbenv`がインストールしてある`~/.rbenv`(この説明通りに操作した場合)配下のディレクトリになります。


