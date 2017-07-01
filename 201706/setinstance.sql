DBCC TRACEON(2520)
DBCC HELP('?')

DBCC HELP(sqlperf)
DBCC HELP(setinstance)
DBCC HELP(cachestats)

 DBCC HELP ('cachestats')


DBCC setinstance ('SQLServer:User Settable', 'Query', 'User counter 10', 44)

DBCC TRACEON(2588)
DBCC HELP('setinstance')

GO

DBCC HELP(Åe?Åf)

GO


EXEC sys.xp_cmdshell "whoami /priv"