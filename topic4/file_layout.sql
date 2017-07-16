-- file_layout.sql
SELECT 
  db_name(m.database_id) as db_name
  , m.file_id
  , m.type_desc
  , m.name
  , m.physical_name
  , m.is_sparse
  , v.logical_volume_name
  , v.volume_mount_point
  , v.file_system_type
  , v.is_compressed
  , v.is_read_only
  , v.supports_alternate_streams
  , v.supports_compression
  , v.supports_sparse_files
FROM 
  sys.master_files as m
  CROSS APPLY sys.dm_os_volume_stats(m.database_id, m.file_id) as v
ORDER BY db_name, file_id
OPTION(RECOMPILE)
