-- db_data_size.sql
-- 一時表の作成
DECLARE @dm_db_file_space_usage table(
  database_name nvarchar(128)
  , source_database_name nvarchar(128)
  , name sysname
  , physical_name nvarchar(260)
  , total_size_kb bigint
  , used_size_kb bigint
  , free_size_kb bigint
  , used_in_percent decimal
  , database_id int
  , file_id int
);
-- sp_MSforeachdbを使用し各データベースに対してクエリを実行し、結果を一時表に格納
INSERT INTO 
  @dm_db_file_space_usage
EXEC sp_MSforeachdb 'USE ?;
SELECT
  DB_NAME(m.database_id)
  , DB_NAME(d.source_database_id)
  , m.name
  , m.physical_name
  , u.total_page_count * 8 AS total_size_kb
  , (CASE m.is_sparse 
      WHEN 1 THEN i.size_on_disk_bytes / 1024
      ELSE u.allocated_extent_page_count * 8 END 
    ) AS used_size_kb
  , u.unallocated_extent_page_count * 8 AS free_size_kb
  , FORMAT(CONVERT(decimal, u.allocated_extent_page_count) / u.total_page_count * 100, ''0.00'') AS used_in_percent
  , m.database_id
  , m.file_id
FROM sys.master_files m 
  left join sys.dm_db_file_space_usage u on u.database_id = m.database_id and u.file_id = m.file_id
  left join sys.databases d on m.database_id = d.database_id
  CROSS APPLY sys.dm_io_virtual_file_stats(m.database_id, m.file_id) as i
WHERE m.database_id = DB_ID() and m.type = 0
ORDER BY m.database_id, m.file_id
'
-- 一時表の結果を集計して返却
select * from @dm_db_file_space_usage ORDER BY database_id, file_id
