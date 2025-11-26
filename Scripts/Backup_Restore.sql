USE master;
GO

-- 1. Restauration de la base AdventureWorks (avec déplacement des fichiers)
RESTORE DATABASE AdventureWorks
FROM DISK = 'U:\BKPMKGTDEV\AdventureWorks.bak'
WITH 
    MOVE 'AdventureWorks2019' TO 'C:\SQLData\MKGTDEV\AdventureWorks.mdf',
    MOVE 'AdventureWorks2019_Log' TO 'C:\SQLLogs\MKTGDEV\AdventureWorks.ldf',
    REPLACE, STATS = 10;
GO

-- 2. Sauvegarde SANS compression
BACKUP DATABASE AdventureWorks
TO DISK = 'U:\BKPMKGTDEV\AdventureWorks_NoComp.bak'
WITH NAME = 'Full Backup - No Compression', NO_COMPRESSION, INIT;
GO

-- 3. Sauvegarde AVEC compression
BACKUP DATABASE AdventureWorks
TO DISK = 'U:\BKPMKGTDEV\AdventureWorks_Comp.bak'
WITH NAME = 'Full Backup - Compressed', COMPRESSION, INIT;
GO

-- 4. Analyse des gains
SELECT database_name, type,
    CAST(backup_size / 1024 / 1024 AS DECIMAL(10, 2)) AS [Taille Mo],
    CAST(compressed_backup_size / 1024 / 1024 AS DECIMAL(10, 2)) AS [Taille Compressee Mo],
    CAST((backup_size - compressed_backup_size) / backup_size * 100 AS DECIMAL(5, 2)) AS [Gain %]
FROM msdb.dbo.backupset
WHERE database_name = 'AdventureWorks' AND backup_start_date > DATEADD(minute, -10, GETDATE())
ORDER BY backup_start_date DESC;
GO
