# Helpdesk guide: 10 common problems and fixes

Standard troubleshooting procedures for a small office (Windows 10/11, Microsoft 365). For every ticket: ask what changed, reproduce the problem, try the simplest fix first, and document the result.

## 1. No network or internet

1. Check the cable or Wi-Fi icon, and whether other devices are affected.
2. Open Command Prompt and run `ipconfig`. An address starting with `169.254` means no DHCP.
3. Run `ipconfig /release`, then `ipconfig /renew`.
4. Run `ping 192.168.x.1` (the gateway), then `ping 8.8.8.8`, then `ping google.com`.
   - Gateway fails: local problem (cable, port, Wi-Fi).
   - 8.8.8.8 works but google.com fails: DNS problem; run `ipconfig /flushdns`.
5. Restart the network adapter, then the PC.
6. Still failing: check the switch port and escalate to network support.

## 2. Wi-Fi connected but no internet

1. Forget the network and reconnect.
2. Run `ipconfig /flushdns` and `netsh winsock reset`, then restart.
3. Check whether the router or access point is reachable from a wired PC.

## 3. Slow computer

1. Open Task Manager (Ctrl + Shift + Esc) and sort by CPU, memory and disk.
2. Disable unneeded startup apps (Task Manager, Startup tab).
3. Check free disk space; below 10-15% free can cause slowdowns.
4. Run Windows Update and a security scan.
5. Restart the PC if uptime is long.

## 4. Cannot log in (domain account)

1. Check the Caps Lock key and keyboard language.
2. Check whether the account is locked or disabled in Active Directory Users and Computers.
3. Reset the password and tick "User must change password at next logon".
4. If the message says the domain is unreachable, check the network (problem 1).

## 5. Outlook not syncing

1. Check the internet connection and that Outlook is not in "Work Offline" mode.
2. Start Outlook in safe mode (Win + R, type `outlook.exe /safe`) to rule out add-ins.
3. Check the mailbox size and the account status in the Microsoft 365 admin center.
4. Recreate the profile (Control Panel, Mail, Show Profiles) if the problem remains.

## 6. Printer offline

1. Check power, paper and cable or network connection.
2. Set the printer to "online" (right-click the printer, untick "Use Printer Offline").
3. Restart the Print Spooler service (`services.msc`, Print Spooler, Restart).
4. Delete stuck jobs from the queue.
5. Reinstall the driver if it still fails.

## 7. Windows update stuck or failing

1. Restart and let it finish; wait before assuming it is frozen.
2. Run the Windows Update troubleshooter (Settings, System, Troubleshoot).
3. Run `sfc /scannow`, then `DISM /Online /Cleanup-Image /RestoreHealth` (as administrator).
4. Check free disk space.

## 8. Forgotten password or locked account

1. Verify the user's identity (call back on a known number or confirm with the manager).
2. Reset the password in Active Directory or the Microsoft 365 admin center.
3. Force a password change at the next login.
4. Never send the password by email or chat.

## 9. Application crashes or will not start

1. Note the exact error message and when it started.
2. Restart the app and the PC.
3. Check for updates and recent changes.
4. Run the app as administrator once to test permissions.
5. Repair or reinstall the application.

## 10. Suspicious email or possible malware

1. Tell the user not to click links or open attachments.
2. Disconnect the PC from the network if it may be infected.
3. Run a full security scan.
4. Change the passwords of affected accounts using a trusted, clean device if compromise is suspected.
5. Report to the IT manager.

## Ticket template

| Field | Example |
|---|---|
| Date / user | 2026-11-11 / Sara Trabelsi |
| Problem | Cannot print to the office printer |
| Steps taken | Restarted the spooler, deleted stuck jobs |
| Result | Resolved |
| Time spent | 15 min |
