# Phase 2 — Active Directory & Group Policy Management

## Project overview

This phase focuses on building and organizing a simulated Windows Server 2025 Active Directory environment for a small business.

The objective is to manage user accounts, security groups, Organizational Units (OUs), and Group Policy Objects (GPOs).

**Environment:** WinLab — Windows Server 2025 browser-based simulator.

> **Note:** This project was completed in a browser-based simulation environment. It demonstrates configuration and administration concepts; it is not a deployment on a physical Windows Server.

## 1. Server configuration

| Component | Configuration |
|---|---|
| Server name | DC1 |
| Operating system environment | Windows Server 2025 Datacenter Evaluation |
| Active Directory domain | company.local |
| NetBIOS name | COMPANY |
| Main role | Active Directory Domain Services (AD DS) |
| DNS | Enabled |

## 2. Organizational Units

Three Organizational Units were created to organize the company's departments:

- **Staff**
- **Management**
- **IT**

## 3. User accounts and security groups

| Department | User accounts | Security group |
|---|---|---|
| Staff | Ahmed Ben Ali, Sara Trabelsi, Youssef Mansour | GG_Staff |
| Management | Leila Gharbi | GG_Management |
| IT | Sami Khelifi | GG_IT |

Each user was placed in the appropriate OU and added to the corresponding global security group.

## 4. Group Policy management

Three Group Policy Objects were created and linked to their respective OUs.

### GPO_Staff_Security

- Prohibit access to Control Panel and PC settings.
- Prevent access to the command prompt.

### GPO_Management_Security

- Enable the screen saver.
- Set the screen saver timeout to 600 seconds.
- Password-protect the screen saver.

### GPO_IT_Security

- Configure **Interactive logon: Machine inactivity limit** to 600 seconds.

## 5. Skills demonstrated

- Windows Server administration concepts.
- Active Directory Domain Services (AD DS).
- Domain and domain controller configuration.
- Organizational Unit (OU) management.
- User account creation and administration.
- Global security group management.
- Group Policy Object creation, configuration, and OU linking.
- Department-based account organization and security policy management.

## Conclusion

This lab demonstrates the basic workflow for organizing a small-business Active Directory environment, assigning users to department-based groups, and applying security policies through Group Policy. All configuration was performed in the WinLab simulator.
