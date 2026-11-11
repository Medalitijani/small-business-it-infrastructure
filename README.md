# Small Business IT Infrastructure

Designing and building the IT environment of a 20-person company from scratch: network, Active Directory, PowerShell automation and documentation.

## Overview

This project simulates the IT setup of a small company with three departments (Staff, Management, IT). I designed and tested the network in Cisco Packet Tracer, built a Windows Server 2025 domain in the WinLab simulator, applied Group Policies, and documented the work with screenshots.

## Phases

| Phase | Description | Status |
|---|---|---|
| [1. Network design](01-network) | VLANs, inter-VLAN routing, DHCP, guest isolation with an ACL (Cisco Packet Tracer) | ✅ Done |
| [2. Active Directory](02-active-directory) | Domain company.local, OUs, users, groups, 3 Group Policies (WinLab Windows Server 2025 simulator) | ✅ Done (simulated lab) |
| [3. PowerShell automation](03-powershell) | Scripts for user creation, inventory and disk checks | ⏳ Planned |
| [4. Support documentation](04-documentation) | Helpdesk guide, onboarding checklist, backup procedure | ⏳ Planned |

## Skills used

- **Networking:** VLANs, 802.1Q trunking, router-on-a-stick, DHCP, access control lists
- **Systems:** Windows Server, Active Directory, Organizational Units, Group Policy
- **Tools:** Cisco Packet Tracer, WinLab (Windows Server simulator), PowerShell, Git/GitHub

## Repository structure

```
01-network/            Packet Tracer project, topology, tests
02-active-directory/   Domain setup and Group Policy screenshots
03-powershell/         Automation scripts
04-documentation/      Guides and procedures
```
## Autho
Mohamed Ali Tijani, junior IT support and network technician, Tunisia.
[LinkedIn](https://www.linkedin.com/in/mohamed-ali-tijani-0ab3a236b/)
