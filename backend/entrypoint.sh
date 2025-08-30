#!/bin/bash
set -e

# サーバースタート時のpidファイルを削除
rm -f /app/tmp/pids/server.pid

# 本番環境ではbundle installを再度実行しない（コンテナビルド時に完了しているため）
if [ "$RAILS_ENV" = "production" ]
then
    bundle install
fi

# データベースの準備（dbコンテナの起動を待つ）
echo "Waiting for PostgreSQL to start..."
until pg_isready -h db -U postgres; do
  echo "..."
  sleep 1
done

echo "PostgreSQL is up and running!"

# データベースのマイグレーション
echo "Running database migrations..."
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:create && bundle exec rails db:migrate

# シードデータの投入（任意）
# echo "Seeding database..."
# bundle exec rails db:seed

# メインプロセスを起動（CMDで指定されたコマンド）
exec "$@"