# 🛡️ Universal Zero-Trust Linux Hardening Framework (Stage 2)

An automated, cross-distribution post-installation security baseline framework designed for **Arch Linux**, **Debian**, **Fedora (RHEL)**, and **openSUSE (Suse)**. This framework applies multi-layer host hardening, kernel optimizations, and defensive daemon shielding across bare-metal server deployments, virtual machines, and local workstations.

## 🚀 Purpose & Architecture

This framework establishes a highly hardened operating state immediately following a baseline OS installation (Stage 1). It uses an intelligent variable-matching engine to map system configurations dynamically based on the target node's detected `os_family`.

### Core Hardening Layers
* **Layer 1: Secure Package Engine** — Forcefully installs critical telemetry, monitoring, and defensive security software tailored to the platform.
* **Layer 2: Hybrid Memory & Kernel Hardening** — Minimizes runtime vector surface via aggressive sysctl restrictions and deploys systemd memory performance parameters (ZRAM with `lz4` optimization).
* **Layer 3: Host Daemon Shielding** — Structures custom cgroup resource throttling limits (CPU/Memory quotas) for resource-heavy services like ClamAV, provisions automated out-of-memory protections via `earlyoom`, and instantiates `arpwatch` network monitoring binds.
* **Layer 4: Leak-Protection Infrastructure** — Validates firewalld presence and deploys automated networking kill-switches (`portalon`/`portaloff`) to inhibit host data leakage.
* **Layer 5: File Integrity & System Auditing** — Hardens `auditd` logging definitions to actively trace administrative structures, user adjustments, and kernel module execution flags.
* **Layer 6: Verification Reporting** — Compiles an end-to-end cryptographic and runtime compliance posture report written directly to `/root/hardening-verification-report.md`.

---

## 📋 Prerequisites & Ecosystem Files

The project infrastructure requires three companion configuration assets to be located in the working path:

### 1. `ansible.cfg`
Enforces operational defaults, pipelines data streams for efficiency, and strictly locks down mandatory privilege escalation parameters:
```ini
[defaults]
inventory = ./hosts.ini
stdout_callback = default
result_format = yaml
interpreter_python = auto_silent
timeout = 60
force_handlers = True

[ssh_connection]
pipelining = True

[privilege_escalation]
become = True
become_ask_pass = True
become_flags = -H -S
```

### 2. `hosts.ini`
Defines target endpoints. When executing on local workstations or training boxes, it bridges directly onto the local loopback shell:
```ini
[hardened_nodes]
localhost ansible_connection=local
```

### 3. `vars_mapping.yml`
Maintains the explicit software and environment variable dictionaries used by the playbook matching matrix to identify distribution-specific boundaries (e.g., service identifiers, security directories, and paths).

---

## 🛠️ Distribution Setup & Environment Package Managers

Before executing the playbook, make sure your specific targeted operating system environment has its foundational dependencies fulfilled:

### A. Arch Linux
```bash
sudo pacman -Syu --needed python python-pip ansible-core
```

### B. Debian
```bash
sudo apt update && sudo apt install -y python3 python3-pip ansible
```

### C. Fedora
```bash
sudo dnf install -y python3 python3-pip ansible-core
```

### D. openSUSE
```bash
sudo zypper install -y python3 python3-pip ansible
```

---

## ⚙️ Usage & Operational Flags

### Workstation vs. Server Deployment Safety Toggle
Because enterprise-grade server hardening options can degrade graphical interactive environments, this playbook includes a protective safety mechanism. 
* Open `Linux-PostHardening.yml` and look at the top `vars` block:
```yaml
vars:
  is_workstation: true  # Toggle to FALSE for clean, headless production servers
```
* When `is_workstation` is set to `true`, the framework bypasses aggressive background constraints (like harsh `earlyoom` thresholds) to keep desktop systems stable.

### 1. Safe Dry-Run Verification (Simulation Mode)
Always validate syntax parsing strings, environment variable interpolation arrays, and state changes via check mode before execution. This pass simulates actions entirely in memory and will **not** modify system configurations:
```bash
ansible-playbook -i hosts.ini Universal-Linux-PostHardening.yml --check --skip-tags=integrity
```
* *Note: `--skip-tags=integrity` is recommended during dry runs to prevent the initial construction phase of filesystem hash registries from executing early.*

### 2. Live Playbook Deployment
To execute the playbook live and permanently apply security rules to the targeted infrastructure:
```bash
ansible-playbook -i hosts.ini Universal-Linux-PostHardening.yml
```

---

## 🔍 Post-Deployment Automated Validation Suite

To verify that your multi-layer zero-trust baseline configurations are active and functioning correctly across any distribution, execute the dedicated verification suite playbook. This suite queries your kernel states, firewall tables, tracking configurations, and cgroup drop-ins using human-readable file string verification loops:

```bash
ansible-playbook -i hosts.ini Verification-Hardening.yml
```

Upon completion, the suite will display an automated, color-coded diagnostic pass checklist tracking all five critical defense layers.

---

## 📊 Posture Reporting

Upon a successful execution pass, the framework compiles an administrative audit summary. Read the compiled diagnostic record directly from your terminal:
```bash
sudo cat /root/hardening-verification-report.md
```
The resulting record details active sysctl restrictions, current ZRAM swap table performance priorities, and the operational initialization states of core system defenses.

