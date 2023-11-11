# illumi-diary
[![Image from Gyazo](https://i.gyazo.com/33aad68569755637c5c79b793f6510c3.png)](https://gyazo.com/33aad68569755637c5c79b793f6510c3)
URL: https://illumi-diary.com/

## サービス概要
1日の中であったポジティブな感情を記録し、幸福感を高める機会を作るサービスです。  
楽しかったこと、嬉しかったこと、頑張ったことなど  
ポジティブな出来事を1日の終わりに振り返ることで  
小さな幸せを見つけられるようになります。

## 主な機能
| 日記投稿 | Clap(拍手) |
|---------|-----------|
|[![Image from Gyazo](https://i.gyazo.com/fda25f8dc0a244fc8343dba7aacf0285.gif)](https://gyazo.com/fda25f8dc0a244fc8343dba7aacf0285)|[![Image from Gyazo](https://i.gyazo.com/72813d195effc147b47be96a2acb0a5c.gif)](https://gyazo.com/72813d195effc147b47be96a2acb0a5c)|
|今日あったいいことを3つ書き出します。  投稿は公開/非公開・コメント許可/非許可を選択できます。|いい1日だったね、と思った分だけClapボタンを押します。　　Maxまで押すと花のアイコンに変わります。|


| 日記一覧 | My日記一覧 |
|---------|-----------|
|[![Image from Gyazo](https://i.gyazo.com/5fde1e0fa570b15bab850caecc137747.gif)](https://gyazo.com/5fde1e0fa570b15bab850caecc137747)|[![Image from Gyazo](https://i.gyazo.com/f50eef624ad5c0e4b697a19d750c264c.gif)](https://gyazo.com/f50eef624ad5c0e4b697a19d750c264c)|
|公開設定した投稿は一覧から見ることができます。  他の人の投稿にも、Clapやコメントができます。|自分の投稿が一覧で見れます。  また、日付を絞って投稿を検索することも可能です。|

## 想定されるユーザー層
ポジティブ思考を身に付けたい人。  
勉強、仕事、家事などのモチベーションを上げたい人。

## サービスコンセプト
日本人は諸外国の人と比べて、幸福感や自己肯定感が低い傾向があると言われています。  
寝る前に学習したことは、記憶効果が高いので、  
1日の終わりによかった出来事や、頑張ったなと思えることを振り返ることで  
脳がポジティブな思考回路を形成できるようになることが期待できます。  
[補足]  
精神科医の樺沢紫苑先生も、以下の著書でポジティブな出来事を3つ書くことを習慣にするのをオススメされています。  
https://amzn.asia/d/eBYhRRV  
https://onl.sc/bRh5iBN

## 差別化ポイント
現状あるポジティブな出来事や頑張ったことの記録/日記アプリと比較して、以下の点がポイントです。
- 自他関わらず複数回押下できる拍手機能
	 → ストレス発散効果や、「すごい！！！」という気持ちをClapボタンの連打に込め、思いを強める効果を狙う
- 習慣化を動機づける機能
	- 続けることでメダル獲得
	- かわいい動物や自分の好きなものを日記投稿後に登場する画像として設定可能
- コメント受付可否設定
- 公開/非公開設定

## 実装機能
### 実装済みの機能
 - メールアドレスとパスワードを利用したユーザー登録 / ログイン機能
 - ソーシャルログイン機能
 - 退会機能
 - パスワードリセット機能
 - ユーザー情報変更機能
 - ゲストログイン機能
 - みんなの日記閲覧機能
 - 日記の一覧表示 / 作成 / 更新 / 削除機能
 - 日記の公開 / 非公開選択機能
 - 日記のコメント可否選択機能
 - 日記の日付検索機能
 - Clap機能(「いいね」の複数回できるバージョンのようなものです)

### 今後追加を検討している機能
 - ポジティブ変換出力機能
 - 選択肢から入力できる機能
 - 通知で記録を促す機能

## 使用技術
### フロントエンド
- Hotwire(Turbo, Stimulus)
- JavaScript
- TailwindCSS
- daisyUI
### バックエンド
- Ruby on Rails 7.0.8
- Ruby 3.2.2
### インフラ
- Heroku
- AWS S3
### データベース
- PostgreSQL

### 画面遷移図
https://www.figma.com/file/vnFmI6GyJesUINESwwIhaS/illumi-diary?type=design&node-id=0%3A1&mode=design&t=oU6hVh25i7wW8SYI-1

### ER図
[![Image from Gyazo](https://i.gyazo.com/07ab1a049a2d183ffb37fff5ab1d2578.png)](https://gyazo.com/07ab1a049a2d183ffb37fff5ab1d2578)
