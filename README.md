# Go API on Cloud Run 構築手順

## go api 作成

- go.mod,main.go を作成
- 以下コマンドを実行
  ```
  go get -u github.com/gin-gonic/gin
  ```
- サーバーが立ち上がることを確認
  ```
  go run main.go
  ```

## インフラ構築 by Terraform

- 以下を参考に構築
  https://qiita.com/takengineer1216/items/40db479a49d77c07b07b

### Terraform に関する注意点

- 以下 googleapis を有効化する必要がある。

  - cloudresourcemanager.googleapis.com
  - artifactregistry.googleapis.com
  - cloudbuild.googleapis.com
  - run.googleapis.com

    ※上記は terraform で有効化できるが、
    そもそも Cloud Run サービスを使うための権限である serviceusage は手動で有効化する必要がある。

## Github Actions によるデプロイ
