# BookmarkBuster
## ■サービス概要  
未読のURLをシンプルに管理できるアプリです。  
URLをブックマークし、未読・既読の状態で整理できます。  
積読解消を助けるシンプルなツールです。  

## ■このサービスへの思い・作りたい理由
読もうと思ってブックマークした記事やサイトが増えすぎて、結局読めずにたまってしまう…そんな経験をしたことはありませんか？
このアプリは、積読を効果的に解消するためのツールを提供し、情報収集をスムーズに進められるようにすることが目標です。
「読みたい」と思った瞬間の気持ちを再び引き出し、気軽に積読を解消していけるサービスを作りたいと思っています。

## ■ユーザー層について
* 情報収集が好きな一般ユーザー：新しい情報をすぐにブックマークするが、後で読み切れないことが多い。  
* 学生やビジネスマン：学習や仕事で参考になる記事を溜め込みがちなので、効率よく整理したい。  
ユーザーが簡単に使えることを重視し、複雑な設定や機能は極力避けます。

## ■サービスの利用イメージ
ユーザーはURLを追加し、未読・既読のステータスを手動で管理します。
未読のURLリストから好きなものを選んで読み進め、読んだ後は既読に変更することで積読を減らしていけます。
シンプルな積読管理を通じて、情報を効果的に活用できるようにします。

## ■ユーザーの獲得について
基本的に無料で利用できる範囲を活用するため、SNSなどでのシンプルなシェアを行い、個人のリーチを広げることを目指します。

## ■サービスの差別化ポイント・推しポイント
既存のブックマーク機能とは異なり、未読/既読を明確に管理する点が特徴です。
複雑な機能を避け、情報を溜め込みがちな人向けに「今すぐできる積読管理」を提供します。

## ■機能候補
### MVPリリース時:

* URLのブックマーク追加機能
* 未読・既読のステータス管理
* タグ付けによる簡単な分類機能
  
### 本リリースまで:

リマインダーや通知機能（無料で可能な範囲）
ユーザー登録とログイン機能（データの保持用）
## ■機能の実装方針予定
* タグ付け機能：
Railsのシンプルなモデル構造でタグを管理し、ユーザーが分類して利用できるようにする。
複雑な検索機能は後回しにし、タグで絞り込む範囲に留めます。

* リマインダー（可能であれば）:
アプリ内の表示にリマインダーを組み込み、長期間未読のURLをリストの上位に表示するなどの工夫をします。
通知APIは費用がかかるので、まずはシンプルなリスト表示で対応します。

* 関連記事おすすめ機能（可能であれば）：
保存したURLに類似する記事を自動でリストアップし、興味のある分野の積読を効率的に整理する。
ここでは、BERTなどの自然言語処理モデルを利用して関連度を判定する方針です。

### 画面遷移図
https://www.figma.com/design/C0WOo4oj50h2lFe97cJD7O/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&node-type=canvas&t=RoOWWscpAgmAS7XR-0

### ER図
![bookmarkbuster_er_diagram](https://github.com/user-attachments/assets/25f33f61-aa2c-485d-a37f-561404d229c0)



