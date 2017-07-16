-- file_size.sql
SELECT  
  db_name(m.database_id) as db_name
  , m.file_id
  , m.type_desc
  , m.name
  , m.physical_name
  , m.size * 8 AS file_size_kb
  , m.max_size
  , m.growth
  , m.is_percent_growth
  , v.available_bytes / 1024 as volume_available_kb
  , v.total_bytes / 1024  as volume_total_kb
FROM 
  sys.master_files as m
  CROSS APPLY sys.dm_os_volume_stats(m.database_id, m.file_id) as v
ORDER BY db_name, file_id
OPTION(RECOMPILE)