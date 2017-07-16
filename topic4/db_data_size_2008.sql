-- db_data_size_2008.sql
EXEC sp_MSforeachdb N'USE ?; EXEC sp_spaceused;'