# eki-db

## 駅データの仕様

|       | 仕様書                                |
|-------|------------------------------------|
| データ仕様 | https://ekidata.jp/doc/            |
| 事業者   | https://ekidata.jp/doc/company.php |
| 路線    | https://ekidata.jp/doc/line.php    |
| 駅     | https://ekidata.jp/doc/station.php |
| 接続駅   | https://ekidata.jp/doc/join.php    |
| 都道府県  | https://ekidata.jp/doc/pref.php    |

## データダウンロード(csv)

[駅データ.jp](https://ekidata.jp/)

## ファイルをインポートするための設定

```shell
mysql --local-infile=1 -u root -p
SELECT @@local_infile;
SET PERSIST local_infile= 1;
```

## SQLを流し込む

```shell
source init/eki.sql
```

## mysqldump

```shell
mysqldump -u ユーザー名 -p データベース名 > 出力ファイル名.sql
# 例
mysqldump -u root -p eki > eki_dump.sql
```
