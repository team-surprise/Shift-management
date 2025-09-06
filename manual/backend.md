# Shift Management Backend 開発ガイド

## 📌 プロジェクト概要
このバックエンドは **Ruby on Rails（通常モード）+ PostgreSQL** で構築されています。  
API だけでなく、Rails のビュー機能も利用し、管理者用の画面（Adminページ）などを直接レンダリングします。  
Docker Compose により、DB・フロントエンドと統合管理されます。

---

## 🚀 環境構築

### 1. 必要なツール
- Docker / Docker Compose
- Git
- WSL2（Windowsの場合）

### 2. 初回セットアップ
```bash
# backend ディレクトリに移動
cd backend

# 環境変数ファイルを作成
cp .env.example .env

# Dockerイメージをビルド（プロジェクトルートで実行）
docker-compose build

# DB作成
docker-compose run backend rails db:create
```

### 3. 起動
```
docker-compose up
```
- Rails: http://localhost:3000
  - /admin/... : 管理画面（HTMLビュー）
  - /api/v1/... : APIエンドポイント

## 🗂 ディレクトリ構造（主要部分）
```
backend/
├── app/
│   ├── assets/              # CSS, JS, 画像などのアセット
│   ├── controllers/         # コントローラ（HTML & API）
│   │   ├── admin/            # 管理画面用コントローラ
│   │   └── api/v1/           # API用コントローラ
│   ├── models/               # モデル（ActiveRecord）
│   ├── views/                # ビュー（ERBテンプレート）
│   └── helpers/              # ビューヘルパー
├── config/
│   ├── database.yml          # DB設定
│   ├── routes.rb             # ルーティング定義
│   └── environments/         # 環境別設定
├── db/
│   ├── migrate/               # マイグレーションファイル
│   └── schema.rb              # DBスキーマ
├── Gemfile
├── Rakefile
└── .env.example

```

## 💡 開発の考え方
- APIとビューの役割分担
  - /api/v1/... : JSONレスポンスを返すAPI
  - /admin/... : HTMLビューを返す管理画面

## 🔄 よくある作業フロー
### モデル作成
```
docker-compose exec backend rails g model Shift name:string start_time:datetime end_time:datetime
docker-compose exec backend rails db:migrate
```
### コントローラ作成（ビューあり）
```
docker-compose exec backend rails g controller admin/dashboard index
```
### コントローラ作成（API用）
```
docker-compose exec backend rails g controller api/v1/shifts index create update destroy
```

## 🛠 コマンド集
```
# DBマイグレーション
docker-compose exec backend rails db:migrate

# マイグレーションのロールバック
docker-compose exec backend rails db:rollback

# Railsコンソール
docker-compose exec backend rails c

# RSpecテスト実行（導入済みの場合）
docker-compose exec backend rspec
```

## 📜 環境変数（例）
.env.example
```
env
DATABASE_HOST=db
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres
```