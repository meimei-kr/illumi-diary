# Docker Hubからruby:3.2.2のイメージをプルする
FROM ruby:3.2.2

# アプリのルートディレクトリ
ENV APP_ROOT /illumi-diary

# 環境設定
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# Node.jsをインストールするための設定スクリプトをダウンロード
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
# Yarnの公開鍵をダウンロードし、APTの追加
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg \
# YarnのAPTリポジトリを追加
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list > /dev/null \
# パッケージリストを更新
&& apt-get update -qq \
# ビルドツール、PostgreSQL開発ライブラリ、Node.js、Yarnをインストール
&& apt-get install -y build-essential libpq-dev nodejs yarn imagemagick

# ルートディレクトリを作成
RUN mkdir ${APP_ROOT}

# 作業ディレクトリを設定
WORKDIR ${APP_ROOT}

# Bundlerをインストール
RUN gem install bundler

# ホストのGemfile、Gemfile.lock、yarn.lockをコピー
COPY Gemfile ${APP_ROOT}/Gemfile
COPY Gemfile.lock ${APP_ROOT}/Gemfile.lock
COPY yarn.lock /app/yarn.lock

# GemfileとGemfile.lockに基づいてRubyの依存関係をインストール
RUN bundle install

# yarn.lockに基づいてNode.jsの依存関係をインストール
RUN yarn install

# ホストのアプリケーションのファイルをコピー
COPY . ${APP_ROOT}

# docker-compose.ymlは複数コンテナを起動する用のcommandが書かれている
# railsサーバー単体で立ち上げて作業したい場合に用いる
CMD ["rails", "server", "-b", "0.0.0.0"]