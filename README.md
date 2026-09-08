# 🛡️ Universal Zero-Trust Linux Hardening Framework (Stage 2)

An automated, cross-distribution post-installation security baseline framework designed for **Arch Linux**, **Debian**, **Fedora (RHEL)**, and **openSUSE (Suse)**. This framework applies multi-layer host hardening, custom kernel optimizations, and defensive daemon shielding across virtual machines, workstations, and enterprise nodes.

---

## 🚀 Purpose & Architecture

This framework establishes a highly hardened operating state immediately following a baseline OS installation. It uses an intelligent variable-matching engine to map system configurations dynamically based on the target node's detected `os_family`.

### Core Hardening Layers
* **Layer 1: Secure Package Engine** — Installs critical telemetry, monitoring, and defensive security software tailored to the specific platform.
* **Layer 2: Hybrid Memory & Kernel Hardening** — Deploys customized systemd-zram configurations and injects optimized memory-tuning parameters.
* **Layer 3: Personal Drop-In Security Baselines** — Enforces distinct, structured `sysctl.d` configuration profiles directly to storage filesystems.
* **Layer 4: Host Daemon Shielding** — Enforces strict cgroup resource throttling limits (CPU/Memory quotas) on heavy engines like ClamAV, provisions automated out-of-memory protections via `earlyoom`, and instantiates `arpwatch` network monitoring.
* **Layer 5: Core Authentication & Auditing (AAA)** — Restructures local system account authorization boundaries, forces multi-round custom PAM authentication lockout thresholds (`pam_faillock`), and hooks active rules directly into `auditd`.
* **Layer 6: Verification Reporting** — Compiles an end-to-end compliance posture report written directly to `/root/hardening-verification-report.md`.

---

## 📋 Prerequisites & Ecosystem Files

The project infrastructure requires three companion configuration assets to be located in your working directory:

### 1. `ansible.cfg`
Enforces operational defaults, pipelines local data streams for efficiency, and strips out conflicting stream hooks:
```ini
[defaults]
inventory = ./hosts.ini
stdout_callback = default
result_format = yaml
interpreter_python = auto_silent
timeout = 300
force_handlers = True

[ssh_connection]
pipelining = True
ssh_args = -o ControlMaster=auto -o ControlPersist=60m -o ConnectionAttempts=100

[privilege_escalation]
become = True
become_ask_pass = False
become_flags = -H
```

### 2. `hosts.ini`
Defines target endpoints. For local workstation environments, it bridges directly onto the local loopback shell:
```ini
[hardened_nodes]
localhost ansible_connection=local
```

### 3. `vars_mapping.yml`
Maintains the explicit software and environment variable dictionaries used by the playbook matching matrix to identify distribution-specific boundaries (e.g., service identifiers, security directories, and paths).

---

## 🛠️ Usage & Operational Flags

### Workstation vs. Server Deployment Safety Toggle
Because enterprise-grade server hardening options can degrade graphical interactive environments, this playbook includes a protective safety mechanism. 
* Open `Universal-Linux-PostHardening.yml` and locate the top `vars` block:
```yaml
vars:
  is_workstation: true  # Toggle to FALSE for clean, headless production servers
```
* When `is_workstation` is set to `true`, the framework bypasses aggressive background constraints (like harsh server-level `earlyoom` thresholds) to keep desktop systems stable.

### 1. Safe Dry-Run Verification (Simulation Mode)
Always validate syntax parsing strings, environment variable interpolation arrays, and state changes via check mode before live execution. To bypass strict, newly-deployed local PAM stream restrictions cleanly, **always execute the playbook via system `sudo`** to handle authentication natively:
```bash
sudo ansible-playbook Universal-Linux-PostHardening.yml --check --skip-tags=integrity
```
* *Note: `--skip-tags=integrity` is recommended during dry runs to prevent the initial construction phase of filesystem hash registries from executing early.*

### 2. Live Playbook Deployment
To execute the playbook live and permanently apply security rules to the targeted infrastructure:
```bash
sudo ansible-playbook Universal-Linux-PostHardening.yml --skip-tags=integrity
```

---

## 🔍 Post-Deployment Automated Validation Suite

To verify that your multi-layer zero-trust baseline configurations are active and functioning correctly across any distribution, execute the dedicated verification suite playbook using system `sudo`:

```bash
sudo ansible-playbook Verification-Hardening.yml
```

Upon completion, the suite will display an automated, color-coded diagnostic pass checklist tracking your critical defense layers.

---

## 📊 Posture Reporting

Upon a successful execution pass, the framework compiles an administrative audit summary. Read the compiled diagnostic record directly from your terminal:
```bash
sudo cat /root/hardening-verification-report.md
```
The resulting record details active sysctl restrictions, current ZRAM swap table performance priorities, and the operational initialization states of core system defenses.

