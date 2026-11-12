# Small Business IT Infrastructure

Designing and documenting the IT environment of a 20-person company: network infrastructure, Active Directory, PowerShell automation, and IT support procedures.

## Project overview

This project simulates the IT setup of a small company with three departments: Staff, Management, and IT.

The work is organized into four phases:

| Phase | Description | Status |
|---|---|---|
| [1. Network design](01-network/README.md) | VLANs, inter-VLAN routing, DHCP, and guest isolation with an ACL (Cisco Packet Tracer) | Completed |
| [2. Active Directory](02-active-directory/README.md) | Domain, organizational units, user accounts, security groups, and Group Policy Objects (WinLab simulator) | Completed in simulation |
| [3. PowerShell automation](03-powershell/README.md) | Scripts for system inventory, disk-space checks, and Active Directory user creation | Scripts documented; AD user creation tested in dry-run mode |
| [4. Support documentation](04-documentation/README.md) | Helpdesk guide, employee onboarding checklist, and backup procedure | Completed |

## Skills demonstrated

- **Networking:** VLANs, 802.1Q trunking, router-on-a-stick, DHCP, and access control lists (ACLs)
- **Systems administration:** Windows Server concepts, Active Directory, Organizational Units, user and group management, and Group Policy
- **Automation:** PowerShell, CIM, CSV processing, and Active Directory cmdlets
- **IT support:** Troubleshooting, ticket documentation, onboarding, backup planning, and restore testing
- **Tools:** Cisco Packet Tracer, WinLab Windows Server simulator, PowerShell, Git, and GitHub

## Repository structure

```text
01-network/            Packet Tracer network design and tests
02-active-directory/   Active Directory and Group Policy documentation
03-powershell/         PowerShell scripts, sample CSV, and screenshots
04-documentation/      Helpdesk, onboarding, and backup procedures
```

## Environment and testing notes

- The network design was created in Cisco Packet Tracer.
- The Active Directory phase was completed in the WinLab browser-based simulator, not on a physical Windows Server.
- The system inventory and disk-space scripts were tested on a Windows 11 PC.
- The Active Directory user-creation script was checked using its dry-run option; it has not been executed against a live domain controller.

## Author

Mohamed Ali Tijani — Junior IT Support and Network Technician, Tunisia.

[LinkedIn](https://www.linkedin.com/in/mohamed-ali-tijani-0ab3a236b/)
