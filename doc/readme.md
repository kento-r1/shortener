# 公開URL
http://ec2-54-64-157-60.ap-northeast-1.compute.amazonaws.com/


# APIの仕様
## 短縮用APIへの入力
- POSTとGETの入力を受け付ける。
- LongUrlに短縮するURLを渡す。
    POST http://example.com/api/v1/shortenurl
    Content-Type: application/json
    {“LongUrl”: “http://www.recruit.jp/“}


## 出力
- 短くなったURLと作成時刻が返される。 

    {
	 “ShortUrl”: “http://ec2-54-64-157-60.ap-northeast-1.compute.amazonaws.com/a84Aued”,
	 “Created”: “1417457325”,
	 “LongUrl”: “http://www.recruit.jp/“
	}


# 使用したミドルウェア
- Ruby on Rails
- unicorn
- nginx
- sqlite3


# 設計思想
- Railsの設計思想に則り開発した。


# データの流れ
## 短縮部
- ユーザーからの短縮したいURL入力を受け取ると、ハッシュをとって、短縮URLのドメイン以降の部分を生成する。
- 生成したハッシュと、短縮するURLをデータベースに保存する。

## リダイレクト部
- 短縮URLが呼ばれると、ハッシュ部について、データベースに対する検索がかけられる。
- マッチがあれば、保存されていたLocation先に飛ぶようにredirectの308ヘッダが発行される。
- マッチがなければ、404が返される。


# データの保存戦略
- メンテナンス性を保つために、単純な構造にした。
- 速度を検証したところsqlite3で十分であると判断したため、sqlite3を利用した。

# 処理速度の観点
- 処理速度を確認したところ、どの操作のレスポンスも数msにで済むので、問題ないと思われる。

# 工夫した部分
- redirectの文面を改めるために、ApplicationControllerにredirect_toメソッドを再定義した。

# アピールポイント
- Ruby on Rails上で簡潔にかかれているんで、極めて保守性が高い。
- Rspecを用いて、一連のテストが書かれている。