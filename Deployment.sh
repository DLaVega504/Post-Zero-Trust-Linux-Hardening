#!/bin/bash
# =================================================================
# UNIVERSAL ZERO-TRUST FRAMEWORK AUTOMATED INITIALIZATION WRAPPER
# CUSTOM INFRASTRUCTURE DESIGN BUILT BY MEDARDO VEGA
# =================================================================
set -euo pipefail

# Visual branding headers
echo -e "\033[1;34m======================================================================\033[0m"
echo -e "\033[1;32m🏛️  UNIVERSAL ZERO-TRUST INFRASTRUCTURE HARDENING SUITE\033[0m"
echo -e "\033[1;34m======================================================================\033[0m"

# Step 1: Force a single administrative privilege gate at the very beginning
if [ "$EUID" -ne 0 ]; then
    echo -e "\033[1;33m[*] Administrative authorization required. Elevating privileges...\033[0m"
    exec sudo "$0" "$@"
fi

# Track current framework workspace path locations dynamically
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
cd "${BASE_DIR}"

# Clear out any stale legacy log receipts from previous testing passes safely
rm -f Stage#2-Hardening-Live-Run-Deployment.log Stage#2-Live-Run-Auditing.log

echo -e "\033[1;32m[+] Initiating Stage 2 Zero-Trust Hardening Core Engine...\033[0m"
echo -e "\033[1;34m----------------------------------------------------------------------\033[0m"

# Execute the core hardening deployment play and pipe output simultaneously to screen and file
ansible-playbook -i hosts.ini Stage#2-Post-Hardening.yml | tee Stage#2-Hardening-Live-Run-Deployment.log

# Step 2: The 10-Second Visual Review Intermission Gate
echo -e "\n\033[1;34m======================================================================\033[0m"
echo -e "\033[1;32m✓ CORE HARDENING SUB-SYSTEM DEPLOYMENT TASKS RUN COMPLETED.\033[0m"
echo -e "\033[1;33m⏱️  Pausing for 10 seconds to allow core output verification review...\033[0m"
echo -e "\033[1;34m======================================================================\033[0m"

for count in {10..1}; do
    echo -e "[*] Transitioning to verification audit suite in: ${count}s..."
    sleep 1
done

echo -e "\n\033[1;32m[+] Initiating Stage 2 Core Hardening Verification Audit Suite...\033[0m"
echo -e "\033[1;34m----------------------------------------------------------------------\033[0m"

# Execute the standalone verification audit suite and pipe output to screen and file
ansible-playbook Stage#2-Auditing.yml | tee Stage#2-Live-Run-Auditing.log

# Step 3: The Cryptographic Dual-Receipt Integrity Gate Check
echo -e "\n\033[1;34m======================================================================\033[0m"
echo -e "\033[1;33m🔬 RUNTIME FRAMEWORK INTEGRITY GATE AUDIT CHECK...\033[0m"
echo -e "\033[1;34m======================================================================\033[0m"

if [ -f "Stage#2-Hardening-Live-Run-Deployment.log" ] && [ -f "Stage#2-Live-Run-Auditing.log" ]; then
    echo -e "\033[1;32m[ SUCCESS ] Hardening Core Receipt Verified  : Stage#2-Hardening-Live-Run-Deployment.log\033[0m"
    echo -e "\033[1;32m[ SUCCESS ] Verification Audit Metric Verified: Stage#2-Live-Run-Auditing.log\033[0m"
    echo -e "\033[1;34m----------------------------------------------------------------------\033[0m"
    echo -e "\033[1;32m🏆 SUCCESSFUL DEPLOYMENT: STAGE 2 COMPLIANCE PHASE COMPLETELY PASSED!\033[0m"
    echo -e "\033[1;32m🥇 OVERALL DESIGN STATUS: [ PENTAGON-LEVEL ZERO-TRUST ARCHITECTURE ]\033[0m"
else
    echo -e "\033[1;31m[-] CRITICAL ERROR: Security deployment tokens or validation files are missing.\033[0m"
    echo -e "\033[1;31m[-] Framework perimeter cannot guarantee un-compromised system safety.\033[0m"
    exit 1
fi
echo -e "\033[1;34m======================================================================\033[0m\n"

# =============================================================================
# STEP 4: THE FINAL CRITICAL AUTHENTICATION POSTURE SHIFT REMINDER
# =============================================================================
echo -e "\033[1;31m################================================================================######\033[0m"
echo -e "\033[1;33m🚨 🚨 CRITICAL AUTHENTICATION REMINDER: PASS-WD HASH REGENERATION REQUIRED 🚨 🚨\033[0m"
echo -e "\033[1;31m################================================================================######\033[0m"
echo -e "\033[1;37m"
echo -e "  ⚠️  ATTENTION: The Stage 2 Post-Hardening Framework has successfully executed."
echo -e "  Your 65,536-round SHA512 cryptographic password-stretching PAM parameters are armed."
echo -e ""
echo -e "  To prevent a catastrophic system lockout on your next interactive session initialization loop,"
echo -e "  you MUST force an immediate update of your account credentials right now:"
echo -e ""
echo -e "  ➡️  1. Enforce Regular Account Hash Shift  : Execute 'passwd'"
echo -e "  ➡️  2. Enforce Administrative Root Hash Shift : Execute 'passwd root'"
echo -e "\033[0m"
echo -e "\033[1;31m################================================================================######\033[0m\n"

