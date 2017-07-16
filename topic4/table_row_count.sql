USE DB001
SELECT 
    o.name AS TableName
    , i.name AS IndexName
    , s.row_count AS NumOfRows
    , s.used_page_count AS NumOfPages
    , CAST(s.used_page_count AS numeric(38)) * 8 AS SizeKB
FROM
    sys.objects o
    LEFT JOIN sys.dm_db_partition_stats s ON s.object_id = o.object_id
    LEFT JOIN sys.indexes i ON i.object_id = s.object_id AND i.index_id = s.index_id
WHERE o.type = 'U'
ORDER BY o.Name
OPTION(RECOMPILE)