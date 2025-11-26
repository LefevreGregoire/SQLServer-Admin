USE master;
GO

-- 1. Modification des fichiers existants (Déplacement + Redimensionnement)
ALTER DATABASE tempdb 
MODIFY FILE (NAME = tempdev, FILENAME = 'C:\SQLData\MKGTDEV\tempdb.mdf', SIZE = 30MB, FILEGROWTH = 10MB);
GO

ALTER DATABASE tempdb 
MODIFY FILE (NAME = templog, FILENAME = 'C:\SQLLogs\MKTGDEV\templog.ldf', SIZE = 10MB, FILEGROWTH = 10MB);
GO

-- 2. Ajout des fichiers secondaires
ALTER DATABASE tempdb 
ADD FILE (NAME = tempdev2, FILENAME = 'C:\SQLData\MKGTDEV\tempdb_file2.ndf', SIZE = 20MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10MB);
GO

ALTER DATABASE tempdb 
ADD FILE (NAME = tempdev3, FILENAME = 'C:\SQLData\MKGTDEV\tempdb_file3.ndf', SIZE = 20MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10MB);
GO
