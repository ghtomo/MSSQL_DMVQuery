-- table_data_size.sql
USE DB001
-- 一時表の作成
DECLARE @temp table(
  name NVARCHAR(128)
  , rows bigint
  , reserved nvarchar(80)
  , data nvarchar(80)
  , index_size nvarchar(80)
  , unused nvarchar(80)
);
-- テーブルごとにsp_spaceusedを実行し結果を一時表に登録
INSERT INTO
  @temp
EXEC sp_MSforeachtable N'exec sp_spaceused ''?''';
-- 結果を出力
SELECT * FROM @temp