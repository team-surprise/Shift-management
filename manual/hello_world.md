# 🎯 ゴール
- ブラウザで `http://localhost:5173` を開いたときに 「Hello, World」 が表示される
- そのメッセージは Rails側のAPIから取得している

## 🧭 全体の流れ（ざっくり）
1. Rails側で「Hello, World」を返すAPIを作る
2. React側でそのAPIを呼び出して、画面に表示する
3. Dockerで両方を起動して、ブラウザで確認する


## 🛠 ステップ1：RailsでAPIを作る

### ① コントローラを作る
```
docker-compose exec backend rails g controller api/v1/hello index
```

### ② コントローラの中身を書く
`backend/app/controllers/api/v1/hello_controller.rb` を開いて、こう書きます：
```
module Api
  module V1
    class HelloController < ApplicationController
      def index
        render json: { message: "Hello, World" }
      end
    end
  end
end
```

### ③ ルーティングを追加
`backend/config/routes.rb` に以下を追加します：
```
namespace :api do
  namespace :v1 do
    get 'hello', to: 'hello#index'
  end
end
```

### ④ 動作確認
```
docker-compose restart backend
```
ブラウザで `http://localhost:3000/api/v1/hello` にアクセスすると：
と表示されればOK！
json形式
```
{ "message": "Hello, World" }
```

 
## 🛠 ステップ2：Reactで画面を作る

### ① API呼び出し関数を作る
`frontend/src/features/hello/api/getHello.ts` を作成：
```
export async function getHello(): Promise<string> {
  const res = await fetch(`${import.meta.env.VITE_API_BASE_URL}/api/v1/hello`)
  const data = await res.json()
  return data.message
}
```

### ② 表示用コンポーネントを作る
`frontend/src/features/hello/components/HelloMessage.tsx` を作成：
```
import { useEffect, useState } from 'react'
import { getHello } from '../api/getHello'

export default function HelloMessage() {
  const [message, setMessage] = useState('')

  useEffect(() => {
    getHello().then(setMessage).catch(console.error)
  }, [])

  return <h1>{message}</h1>
}
```

### ③ ページに組み込む
`frontend/src/pages/Home.tsx` に以下を追加：
```
import HelloMessage from '../features/hello/components/HelloMessage'

export default function Home() {
  return (
    <div>
      <HelloMessage />
    </div>
  )
}
```

### ④ 環境変数を設定
`frontend/.env` に以下を追加：
```
VITE_API_BASE_URL=http://localhost:3000
```

## 🚀 ステップ3：起動して確認
```
docker-compose up
```
ブラウザで `http://localhost:5173` を開くと：

`Hello, World`

と表示されれば成功です！

## 🧠 補足：なにが起きているの？
| 役割   | 説明                                                             | 
| :----: | ---------------------------------------------------------------- | 
| Rails  | <br>`/api/v1/hello` で JSON `{ message: "Hello, World" } `を返す | 
| React  | <br>fetch でそのAPIを呼び出し、画面に表示する                    | 
| Docker | <br>両方のサーバーを同時に起動してくれる                         | 
