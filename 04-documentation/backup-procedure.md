# Backup procedure

## Goal

Protect the company's data against deletion, hardware failure and ransomware, and be able to restore it.

## Rule: 3-2-1

- **3** copies of the data (the original plus two backups).
- **2** different types of storage (for example, the PC disk and an external drive).
- **1** copy stored off-site or in the cloud (for example, OneDrive or another cloud service).

## What to back up

- User documents and shared folders.
- Important databases and application data.
- Exported configuration files (network devices, for example the Packet Tracer `.pkt` file).
- The Active Directory system state (on a real domain controller).

## Schedule

| Type | Frequency | Retention |
|---|---|---|
| Incremental | Daily | 7 days |
| Full | Weekly | 4 weeks |
| Off-site copy | Weekly | 3 months |

## Simple method on Windows: Robocopy

Copy a folder to an external drive without deleting anything at the destination:

```powershell
robocopy C:\Data E:\Backup\Data /E /R:2 /W:5 /LOG:E:\Backup\backup-log.txt
```

- `/E` copies subfolders including empty ones.
- `/R:2 /W:5` retries twice with a 5-second wait.
- `/LOG` writes a log you can review.

Avoid the `/MIR` option unless you are sure about it: it also deletes at the destination any file removed from the source.

## Automate it

Use Windows Task Scheduler to run the command every night, and check the log each morning.

## Test the restore

A backup that was never restored is not proven. Every month:

1. Pick a few random files from the backup.
2. Restore them to a different folder.
3. Open them and check they are intact.
4. Record the date and the result in the log.

## Ransomware protection

- Keep one copy disconnected or in a cloud service with version history.
- Do not leave the backup drive plugged in all the time.
- Keep the system and antivirus updated, and train users about suspicious emails.
