USE master;
GO

-- Création de la base RateTracking avec Filegroups
CREATE DATABASE RateTracking
ON PRIMARY 
( NAME = RateTracking_dat, FILENAME = 'C:\SQLData\MKGTDEV\RateTracking.mdf', SIZE = 100MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10% ),
FILEGROUP USERDATA
( NAME = RateTracking_dat_1, FILENAME = 'C:\SQLData\MKGTDEV\RateTracking_1.ndf', SIZE = 100MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10% ),
( NAME = RateTracking_dat_2, FILENAME = 'C:\SQLData\MKGTDEV\RateTracking_2.ndf', SIZE = 100MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10% ),
( NAME = RateTracking_dat_3, FILENAME = 'C:\SQLData\MKGTDEV\RateTracking_3.ndf', SIZE = 100MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10% ),
( NAME = RateTracking_dat_4, FILENAME = 'C:\SQLData\MKGTDEV\RateTracking_4.ndf', SIZE = 100MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10% )
LOG ON 
( NAME = RateTracking_log, FILENAME = 'C:\SQLLogs\MKTGDEV\RateTracking.ldf', SIZE = 50MB, MAXSIZE = 2GB, FILEGROWTH = 10% );
GO
