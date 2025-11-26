USE master;
GO

-- 1. Création des Logins SQL (Authentification Mixte)
CREATE LOGIN consult WITH PASSWORD = 'C0nsulT', CHECK_POLICY = OFF;
CREATE LOGIN redact WITH PASSWORD = 'REd@cT', CHECK_POLICY = OFF;

-- 2. Création Dynamique des Logins Windows (User1/User2)
DECLARE @MachineName NVARCHAR(100) = CAST(SERVERPROPERTY('MachineName') AS NVARCHAR(100));
DECLARE @SQL NVARCHAR(MAX);
SET @SQL = 'CREATE LOGIN [' + @MachineName + '\User1] FROM WINDOWS;'; EXEC(@SQL);
SET @SQL = 'CREATE LOGIN [' + @MachineName + '\User2] FROM WINDOWS;'; EXEC(@SQL);
GO

-- 3. Attribution des droits dans AdventureWorks
USE AdventureWorks;
GO

-- Création des utilisateurs
CREATE USER consult FOR LOGIN consult;
CREATE USER redact FOR LOGIN redact;

DECLARE @MachineName2 NVARCHAR(100) = CAST(SERVERPROPERTY('MachineName') AS NVARCHAR(100));
DECLARE @SQL_User1 NVARCHAR(MAX);
SET @SQL_User1 = 'CREATE USER [User1] FOR LOGIN [' + @MachineName2 + '\User1];'; EXEC(@SQL_User1);
DECLARE @SQL_User2 NVARCHAR(MAX);
SET @SQL_User2 = 'CREATE USER [User2] FOR LOGIN [' + @MachineName2 + '\User2];'; EXEC(@SQL_User2);

-- Attribution des Rôles
ALTER ROLE db_datareader ADD MEMBER consult;
ALTER ROLE db_datareader ADD MEMBER [User1];
ALTER ROLE db_owner ADD MEMBER redact;
ALTER ROLE db_owner ADD MEMBER [User2];
GO
