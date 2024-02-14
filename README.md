# eki-db


## DB構築手順

### 前準備 

リポジトリをクローンする
```shell
git clone git@github.com:SOTAkkkk/eki-db.git
```
クローンしたリポジトリに移動する
```shell
cd eki-db
```

ファイルをインポートするための設定を行う
```shell
mysql --local-infile=1 -u root -p
SELECT @@local_infile;
SET PERSIST local_infile= 1;
```

### SQLを流し込む

```shell
source init/eki.sql
```

これで完成

## 補足

### 駅データの仕様

|       | 仕様書                                |
|-------|------------------------------------|
| データ仕様 | https://ekidata.jp/doc/            |
| 事業者   | https://ekidata.jp/doc/company.php |
| 路線    | https://ekidata.jp/doc/line.php    |
| 駅     | https://ekidata.jp/doc/station.php |
| 接続駅   | https://ekidata.jp/doc/join.php    |
| 都道府県  | https://ekidata.jp/doc/pref.php    |


### MySQLのデータをSQLに変換したい場合

```shell
mysqldump -u ユーザー名 -p データベース名 > 出力ファイル名.sql
# 例
mysqldump -u root -p eki > eki_dump.sql
```

### データダウンロード(csv)

[駅データ.jp](https://ekidata.jp/)

