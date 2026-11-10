# Phase 1 – Small Business Network Infrastructure

## Project Overview

Designed and configured a small business network infrastructure using Cisco Packet Tracer, simulating a company environment with Staff, Management and Guest networks.

## Network Architecture

The network includes:
- 1 Cisco 2911 Router
- 1 Cisco 2960 Switch
- 3 Staff PCs
- 1 Server
- 1 Wireless Access Point
- 1 Guest Laptop


## VLAN Configuration

| VLAN | Name | Network |
|---|---|---|
| 10 | Staff | 192.168.10.0/24 |
| 20 | Management | 192.168.20.0/24 |
| 30 | Guests | 192.168.30.0/24 |

## IP Addressing

| Device | IP Address |
|---|---|
| Router – Staff Gateway | 192.168.10.1 |
| Router – Management Gateway | 192.168.20.1 |
| Router – Guest Gateway | 192.168.30.1 |
| Server1 | 192.168.20.10 |
| Staff PCs | DHCP |
| Guest Laptop | DHCP |

## Technologies Used

- Cisco Packet Tracer
- VLANs
- Inter-VLAN Routing
- DHCP
- IEEE 802.1Q
- Wireless Networking
- Extended Access Control Lists (ACLs)

## Security Implementation

Configured an extended ACL to:
- Block Guest access to the Staff network.
- Block Guest access to the Management network.
- Allow DHCP traffic.
- Permit other Guest network traffic.

## Network Testing

| Test | Expected Result | Result |
|---|---|---|
| Staff PC → Server | Successful | PASS |
| Guest → Server | Blocked | PASS |
| Guest → Staff | Blocked | PASS |

## Project Files

- `office-network.pkt` – Cisco Packet Tracer project.
- Screenshots – Network configuration and connectivity tests.

## Skills Developed

- Network configuration and troubleshooting.
- VLAN segmentation.
- Router and switch configuration.
- DHCP configuration.
- Wireless network configuration.
- Network security and ACL implementation.
