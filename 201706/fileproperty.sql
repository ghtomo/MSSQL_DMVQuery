
Select convert(decimal,fileproperty(name, 'SpaceUsed'))/size as Used ,*
From dbo.sysfiles


select format(convert(decimal, 10)/3,'0.00')

DBCC SQLPERF(LOGSPACE)



EXEC sp_MSforeachdb 'USE ?; 
IF (SELECT count(*) FROM sys.master_files WHERE database_id = DB_ID() AND type = 1) > 0
BEGIN
  SELECT
    *
  FROM
    sys.dm_db_log_space_usage
END
'