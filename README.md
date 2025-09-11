# シフト管理 開発ガイド
📌 プロジェクト概要
このプロジェクトは **Rails（通常モード） + React (Vite) + PostgreSQL** を Docker 上で動かすシフト管理アプリケーションです。
Rails 側では API だけでなく **ビュー（HTML, ERB, CSS, JS）も利用**し、管理者用の画面（Adminページ）などを直接レンダリングします。
チーム全員が同じ環境で開発できるよう、Docker Compose によりバックエンド・フロントエンド・DBを統合管理します。

## 🚀 環境構築
### 1. 必要なツール
- Docker / Docker Compose
- Git
- Node.js（ローカルで直接動かす場合のみ）
- WSL2（Windowsの場合）

### 2. 初回セットアップ
```
# リポジトリをクローン
git clone git@github.com:＜your-org＞/shift-management.git
cd shift-management

# 環境変数ファイルを作成
cp frontend/.env.example frontend/.env
cp .env.example backend/.env

# Dockerイメージをビルド
docker-compose build

# DB作成
docker-compose run backend rails db:create
```

### 3. 起動
```
docker-compose up
```
- フロントエンド: http://localhost:5173
- バックエンド(API): http://localhost:3000

### 🗂 ディレクトリ構造（フロントエンド）
```
frontend/
├── public/               # 静的ファイル
├── src/
│   ├── assets/           # 画像・フォント・CSSなど
│   ├── components/       # 汎用UI部品
│   ├── features/         # 機能単位のまとまり
│   │   └── hello/
│   │       ├── api/        # API呼び出し関数
│   │       ├── components/ # 機能専用UI部品
│   │       ├── hooks/      # 機能専用カスタムフック
│   │       └── types.ts    # 型定義
│   ├── hooks/            # 全体で使うカスタムフック
│   ├── layouts/          # ページ共通レイアウト
│   ├── pages/            # ページコンポーネント（ルーティング単位）
│   ├── services/         # APIクライアントや外部サービス連携
│   ├── store/            # 状態管理
│   ├── styles/           # グローバルCSSやテーマ
│   ├── types/            # 全体で使う型定義
│   ├── utils/            # 汎用関数
│   ├── main.tsx          # エントリーポイント
│   └── vite-env.d.ts
```

## 💡 開発の考え方（島モデル）
- src … アプリ本体
- features … 機能の島（API/UI/ロジックを完結させる）
- components … 汎用UI部品
- pages … URL単位の画面。組み立て役
- services … 外部サービスやAPIクライアント
- styles / assets … 見た目
- utils / types … 共通知恵
- store … 全体状態
- Rails 側 … APIエンドポイントとビュー（管理画面など）を提供

## 🔄 よくある作業フロー
### 新機能追加
1. `features/＜機能名＞` を作成
2. `api/` にAPI呼び出し関数を作成
3. `hooks/` にデータ取得や状態管理のロジックを作成
4. `components/` にUI部品を作成
5. `pages/` にページを作り、機能部品を組み合わせる

### 新機能追加（Rails側）
- コントローラとビューを作成
- 必要に応じてルーティングを追加
- ERBやCSSで画面を整える
- APIとしても利用する場合はJSONレスポンスも実装

## 🛠 コマンド集
### バックエンド（Rails）
```
# DBマイグレーション
docker-compose exec backend rails db:migrate

# モデル作成
docker-compose exec backend rails g model ModelName field:type

# コントローラ作成（ビューあり）
docker-compose exec backend rails g controller Admin::Dashboard index
```

### フロントエンド（React）
```
# パッケージ追加
docker-compose exec frontend npm install package-name

# 開発サーバー再起動
docker-compose restart frontend
```


## 📜 環境変数
- frontend/.env
```
VITE_API_BASE_URL=http://localhost:3000
```

- backend/.env
```
DATABASE_HOST=db
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres
```

## 🤝 コントリビュート方法
1. 新しいブランチを作成
2. コードを変更
3. docker-compose up で動作確認
4. PRを作成

## 🧩 チーム開発Tips
- 機能ごとに `features/` に閉じ込める（React側）
- ページは組み立てだけにする（React側）
- API呼び出しは `api/` に集約
- 型は近くに置く（機能固有はfeatures内、共通はsrc/types）
- `.env.example` を常に最新に保つ
- Rails 側のビューは `app/views` に配置し、管理画面や内部ツールを提供
