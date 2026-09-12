# Universal Zero-Trust Linux Hardening Framework (Stage 2)

An enterprise-grade, post-installation configuration framework built with Ansible. This playbook applies zero-trust security controls, hybrid memory tuning, dual-layer file integrity tracking, and proactive network perimeter containment across **Arch Linux, Debian, Fedora, and openSUSE**.

## 🧠 Architectural Memory Sizing Matrix
The playbook dynamically scans host system hardware metrics on the fly to automatically configure a balanced hybrid swap tier profile:

| Discovered Host RAM | Active Memory Infrastructure Setup | Target Kernel `vm.swappiness` |
| :--- | :--- | :--- |
| **7 GB or Less** (e.g., 4GB Laptop) | Hybrid Active: `RAM * 2` Compressed ZRAM Pool + Disk Fallback Swapfile | `150` (Aggressive ZRAM Offloading) |
| **8 GB to 16 GB** (e.g., Workstation) | Hybrid Active: `RAM + 3GB` Physical Allocation (Hibernation Cushion) | `100` (Balanced Desktop Hybrid) |
| **Greater than 16 GB** (e.g., Server) | Aborted Hybrid: ZRAM Fully Masked. Standard 4GB Static Disk Swap Only | `10` (Standard Storage Fallback) |

## 🛡️ Core Hardening Mechanisms

### 1. Storage & Process Isolation
* **Zero-Trust Mounting:** Restructures `/etc/fstab` layout parameters (`nodev`, `nosuid`, `noexec`) across critical paths using Btrfs subvolumes pinned cleanly to `/dev/mapper/cryptroot`.
* **Process Shielding:** Restricts runtime system visibility (`ProtectProc=invisible`) inside `systemd-logind` parameters.

### 2. Multi-Distribution Integrity Verification
* **Automated Ancoster Path Provisioning:** Dynamically handles Debian directory omissions (`/etc/audit/rules.d/`) hands-free before file drops execute.
* **Dual-Layer FIM Split:** Automatically deploys **AIDE** globally across all environments while gracefully orchestrating **Tripwire** snapshot baselines only on non-Arch Linux nodes.

### 3. Network Perimeter Containment (Dual-Kill Switch)
* **Stage 1 (Hardware Discovery):** Dynamically tracks active hardware interfaces using pattern-matching regex arrays (`^(wlan|wl).*`) to locate wireless adapters across different kernels.
* **Stage 2 (Hardened Enforcement):** Binds your physical interface straight into Firewalld's `block` zone by default, leaving virtual VPN adapters (`proton+`, `wg+`) wide open in the `trusted` zone.
* **Stage 3 (Manual Portal Aliases):** Drops persistent shell toggles inside `/etc/profile.d/` to manage restrictive captive portal logins on public Wi-Fi networks safely.
## 📋 Execution Prerequisites

Before running the deployment script, ensure your local directory tree features both core architectural framework files:

1. `Universal-Linux-PostHardening.yml` (The 13-Block Core Playbook)
2. `vars_mapping.yml` (The Cross-Distribution Translation Map Dictionary)

### 🖥️ Headless Server Inclusions
For headless or cloud target installations that lack discrete display adapters or wireless cards, prevent hardware check faults by appending the explicit workstation flag parameter to your Ansible inventory definition:

```ini
[hardened_nodes]
your-server-ip-or-hostname is_workstation=false
```
## 🕹️ Stage 3 Portal Alias Toggles

When deploying to a mobile workstation laptop or desktop (`is_workstation=true`), network cleartext leakage is aggressively blocked on boot. When navigating public gateways or cafe Wi-Fi networks, interact with the system using these two built-in shell aliases:

*   **`portaloff`**: Moves your active network interface into the `public` zone. Use this *only* to display the network's captive page, fill out the prompt, and pass authentication.
*   **`portalon`**: Instantly slams protection back down, moving your interface card back into the `block` zone the split-second your secure ProtonVPN cryptographic tunnel is safely established.
## 🚀 Running the Playbook

### 1. Safe Syntax Check Pass
Always run a basic syntactic evaluation pass before deploying code changes to live production machines:
```bash
ansible-playbook --syntax-check Universal-Linux-PostHardening.yml
```

### 2. Verification Dry-Run Pass
Simulate the full operational lifecycle inside memory without modifying files using the check modifier:
```bash
ansible-playbook --check Universal-Linux-PostHardening.yml
```

### 3. Production Live Run
Commit all hardening parameters and system configurations permanently to your hardware:
```bash
sudo ansible-playbook Universal-Linux-PostHardening.yml
```

### 🔄 Critical Post-Deployment Step
Because this framework drops low-level kernel hooks (`sysctl.d`), security variables, and modifies your permanent disk map configurations (`fstab`), **the updates will not attach securely until you reboot the host**. Once the play registers `failed=0`, safely cycle your machine:
```bash
sudo reboot
```

