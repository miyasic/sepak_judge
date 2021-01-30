# SepakJudge
セパタクロー大会のスコアシートアプリ

<img src="https://user-images.githubusercontent.com/62228968/106133403-8c3add00-61a8-11eb-86e7-aca6c9dcd75f.JPG" width= 100>

## AppStoreのリンク
https://itunes.apple.com/jp/app/id1551240373?mt=8

※現在iOSのみのリリースとなっています。Androidの対応も実装中なので、もうしばらくお待ちください。

## アプリ作成の目的
セパタクローは日本においてはマイナーなスポーツであり、認知度も競技人口も少ない。
そのため、日本国内で行われる多くのセパタクロー大会は大会主催者側のメンバーが選手である場合がほとんとである。
そこで、大会の運営コストを少しでも下げることがこのアプリ作成の最大のモチベーションである。

## SepakJudgeの技術選定
セパタクロー界にはアプリをエンジニアにお願いして作ってもらうほどの余裕はない。たぶん。

そこで、このアプリを作成しようと考えたが初心者の自分が1人で作るにはandroidもiOSも両方勉強して両方作るのは途方もないと考えクロスプラットフォームであるflutterを用いることにした。

## 本アプリでできること
・試合の得点を数えることができます。

・試合結果を他のアプリに出力できます。（csv形式）

・試合前に対戦カードを読み込むこともできます。(csv形式)


## 開発時の画像

<img src="https://user-images.githubusercontent.com/62228968/106133400-8b09b000-61a8-11eb-9001-f8335a62244d.PNG" width= 200>  <img src="https://user-images.githubusercontent.com/62228968/106133394-89d88300-61a8-11eb-81ed-519b0b71e155.PNG" width= 200>  <img src="https://user-images.githubusercontent.com/62228968/106133385-880ebf80-61a8-11eb-977d-64ce6e495219.PNG" width= 200>  <img src="https://user-images.githubusercontent.com/62228968/106133376-83e2a200-61a8-11eb-9037-6ad2a6335d0e.PNG" width= 200>


## 今後付け加える予定の機能
FireBaseを用いた試合結果管理機能（現在はcsv形式のファイルデータでの大会本部との通信を想定しているが、今後のアップデートでFireBaseのFireStoreを用いて本部との通信を行えるようにすることを考えている）
