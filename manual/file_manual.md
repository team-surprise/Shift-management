## 🧩 React側：画面を作るときに使うフォルダ
Reactは「画面を描画する側」なので、以下のディレクトリが中心になります。

### コード
```
frontend/src/
├── pages/              # URL単位の画面（例: ShiftList.tsx）
├── features/           # 機能単位のまとまり（API・UI・ロジック）
│   └── shift/
│       ├── api/        # Rails APIを呼び出す関数（fetch/axios）
│       ├── hooks/      # データ取得・状態管理のカスタムフック
│       ├── components/ # 機能専用のUI部品（ShiftTableなど）
│       └── types.ts    # 型定義（Shift型など）
├── components/         # 汎用UI部品（Buttonなど）
├── services/           # APIクライアントの共通設定（axiosなど）
├── styles/             # CSS・テーマ
```
### Reactで画面を作るときの流れ
1. `pages/ShiftList.tsx` に画面の骨組みを作る
2. `features/shift/api/getShifts.ts` で Rails API を呼び出す関数を定義
3. `features/shift/hooks/useShifts.ts` でデータ取得ロジックをまとめる
4. `features/shift/components/ShiftTable.tsx` で表示用UIを作る
5. `ShiftList.tsx` でそれらを組み合わせて画面を完成させる


## 🔗 Rails側：Reactと連携するときに使うフォルダ
Railsは「データを提供する側」なので、Reactが必要とするAPIを以下で構築します。

### コード
```
backend/app/
├── controllers/
│   └── api/v1/shift_controller.rb   # Reactから呼ばれるAPIエンドポイント
├── models/
│   └── shift.rb                     # DBと連携するモデル
├── views/                           # 管理画面などのHTMLビュー（Reactとは別）
├── serializers/（任意）            # JSONの整形（ActiveModel::Serializerなど）
```

## RailsでReactと連携するときの流れ
1. models/shift.rb でデータ構造を定義
2. controllers/api/v1/shifts_controller.rb に API を実装（JSONを返す）
3. routes.rb にルートを追加
```
namespace :api do
  namespace :v1 do
    resources :shifts
  end
end
```
4. React側から fetch('/api/v1/shifts') で呼び出す


## 🧠 役割のまとめ

| 目的        | React側                   | Rails側                           | 
| :---------: | :-----------------------: | :-------------------------------: | 
| 画面の構築  | 	`pages/`, `features/`    | (admin画面は `views/`）           | 
| API呼び出し | 	`features/api/` → fetch | `controllers/api/v1/` → JSON返す | 
| データ定義  | `types.ts`                | `models/`                         | 
| 状態管理    | `hooks/`                  | DBとActiveRecord                  | 
| 共通設定    | `services/apiClient.ts`   | `routes.rb`, `application.rb`     | 