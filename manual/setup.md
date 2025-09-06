# 環境構築セットアップ手順

React + Rails + Docker構成によるシフト管理アプリケーションです。  
チームメンバーがすぐに同じ環境で開発できるよう、環境構築手順をまとめています。

---

## 🚀 使用技術

- **Frontend:** React (Vite + TypeScript)
- **Backend:** Ruby on Rails (通常モード)
- **Database:** PostgreSQL
- **Container:** Docker / Docker Compose

---


---

## 🛠️ 環境構築手順

### ① リポジトリをクローン
```
git clone https://github.com/team-surprise/Shift-management.git
cd Shift-management
```

### ② .env ファイルを作成
※ 必要に応じて環境変数を編集してください。
```
cp frontend/.env.example frontend/.env
cp backend/.env.example backend/.env
```

### ③ Dockerイメージのビルドと起動
```
docker-compose build
docker-compose up
```

### ④ フロントエンドにアクセス
`http://localhost:5173`

### ⑤ バックエンドAPI確認
`http://localhost:3000/api/v1/hello`

## 🧪 動作確認済み
- React → Rails API連携（`/api/v1/hello`）
- CORS設定済み（`rack-cors`）
- Dockerで統合起動確認済み

📄 補足
- `.gitignore` により `.env`, `node_modules`, `log`, `tmp` などは除外済み
- `.env.example` を使って環境構築を統一
- `features/` ディレクトリで機能ごとに分離（例: `hello`, `shift`）

