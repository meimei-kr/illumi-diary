# illumi-diary

## サービス概要
1日の中であったポジティブな感情を記録し、幸福感を高める機会を作るサービスです。  
楽しかったこと、嬉しかったこと、頑張ったことなど  
ポジティブな出来事を1日の終わりに振り返ることで  
小さな幸せを見つけられるようになります。

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

## 差別化ポイント
現状あるポジティブな出来事や頑張ったことの記録/日記アプリと比較して、以下の点がポイントです。
- 自他関わらず複数回押下できる拍手機能
	 → ストレス発散効果や、「すごい！！！」という気持ちを連打に込め、思いを強める効果を狙う
- 習慣化を動機づける機能
	- 続けることでメダル獲得
	- かわいい動物や自分の好きなものを日記投稿後に登場する画像として設定可能
- コメント受付可否設定
- 公開/非公開設定

## 実装機能
### MVP
 - メールアドレスとパスワードを利用したユーザー登録 / ログイン機能
 - パスワードリセット機能
 - ユーザー情報変更機能
 - ゲストログイン機能
 - みんなの日記閲覧機能
 - 日記の一覧表示 / 作成 / 更新 / 削除機能
 - 日記の公開 / 非公開選択機能
 - 日記のコメント可否選択機能
 - 日記の日付検索機能
 - Clap機能

### 今後追加を検討している機能
 - ソーシャルログイン機能
 - 退会機能
 - Twitterシェア機能
 - ポジティブ変換出力機能
 - オートコンプリート機能（過去の記録から）
 - 通知で記録を促す機能
 - RememberMe機能

### 画面遷移図
https://www.figma.com/file/vnFmI6GyJesUINESwwIhaS/illumi-diary?type=design&node-id=0%3A1&mode=design&t=oU6hVh25i7wW8SYI-1

### ER図
[![Image from Gyazo](https://i.gyazo.com/debbbcb1fb55d5f8ab7694d052181999.png)](https://gyazo.com/debbbcb1fb55d5f8ab7694d052181999)
