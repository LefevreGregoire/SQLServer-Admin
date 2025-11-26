USE msdb;
GO

-- 0. Nettoyage préventif
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = 'Backup_AdventureWorks_FULL_Sunday')
    EXEC sp_delete_job @job_name = 'Backup_AdventureWorks_FULL_Sunday';
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = 'Backup_AdventureWorks_DIFF_MonWed')
    EXEC sp_delete_job @job_name = 'Backup_AdventureWorks_DIFF_MonWed';
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = 'Backup_AdventureWorks_DIFF_Friday')
    EXEC sp_delete_job @job_name = 'Backup_AdventureWorks_DIFF_Friday';
GO

-- 1. Job Full Backup (Dimanche 3h)
EXEC sp_add_job @job_name = 'Backup_AdventureWorks_FULL_Sunday';
EXEC sp_add_jobstep @job_name = 'Backup_AdventureWorks_FULL_Sunday', @step_name = 'Full Backup', @subsystem = 'TSQL', @command = 'BACKUP DATABASE AdventureWorks TO DISK = ''U:\BKPMKGTDEV\AdventureWorks_Sunday.bak'' WITH INIT, COMPRESSION';
EXEC sp_add_schedule @schedule_name = 'Schedule_Sunday_3AM', @freq_type = 8, @freq_interval = 1, @freq_recurrence_factor = 1, @active_start_time = 030000;
EXEC sp_attach_schedule @job_name = 'Backup_AdventureWorks_FULL_Sunday', @schedule_name = 'Schedule_Sunday_3AM';
EXEC sp_add_jobserver @job_name = 'Backup_AdventureWorks_FULL_Sunday';

-- 2. Job Diff Backup (Lundi/Mercredi 5h)
EXEC sp_add_job @job_name = 'Backup_AdventureWorks_DIFF_MonWed';
EXEC sp_add_jobstep @job_name = 'Backup_AdventureWorks_DIFF_MonWed', @step_name = 'Diff Backup', @subsystem = 'TSQL', @command = 'BACKUP DATABASE AdventureWorks TO DISK = ''U:\BKPMKGTDEV\AdventureWorks_Diff.bak'' WITH DIFFERENTIAL, INIT, COMPRESSION';
EXEC sp_add_schedule @schedule_name = 'Schedule_MonWed_5AM', @freq_type = 8, @freq_interval = 10, @freq_recurrence_factor = 1, @active_start_time = 050000;
EXEC sp_attach_schedule @job_name = 'Backup_AdventureWorks_DIFF_MonWed', @schedule_name = 'Schedule_MonWed_5AM';
EXEC sp_add_jobserver @job_name = 'Backup_AdventureWorks_DIFF_MonWed';

-- 3. Job Diff Backup (Vendredi 19h)
EXEC sp_add_job @job_name = 'Backup_AdventureWorks_DIFF_Friday';
EXEC sp_add_jobstep @job_name = 'Backup_AdventureWorks_DIFF_Friday', @step_name = 'Diff Backup Fri', @subsystem = 'TSQL', @command = 'BACKUP DATABASE AdventureWorks TO DISK = ''U:\BKPMKGTDEV\AdventureWorks_Diff_Fri.bak'' WITH DIFFERENTIAL, INIT, COMPRESSION';
EXEC sp_add_schedule @schedule_name = 'Schedule_Friday_7PM', @freq_type = 8, @freq_interval = 32, @freq_recurrence_factor = 1, @active_start_time = 190000;
EXEC sp_attach_schedule @job_name = 'Backup_AdventureWorks_DIFF_Friday', @schedule_name = 'Schedule_Friday_7PM';
EXEC sp_add_jobserver @job_name = 'Backup_AdventureWorks_DIFF_Friday';
GO
