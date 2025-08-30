# 使用するRubyのベースイメージを指定
FROM ruby:3.2.0

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# アプリケーションの作業ディレクトリを設定
WORKDIR /app

# Gemfileをコピーし、依存関係をインストール
COPY Gemfile Gemfile.lock ./
RUN bundle install

# ソースコードをコンテナにコピー
COPY . .

# コンテナがリッスンするポートを公開
EXPOSE 3000

# Railsサーバーを起動するコマンド
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]