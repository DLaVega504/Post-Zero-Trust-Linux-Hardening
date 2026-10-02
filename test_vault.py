# Let's verify the Jinja2 rendering logic for processing the raw storage lines.
# We will simulate the raw lines, split them, access their fields using explicit array index numbers,
# and check if the filtering logic performs correctly.
import re

discovered_raw_storage_matrix = [
    "/dev/sda1|crypto_LUKS|576|/",
    "/dev/sda2|EMPTY|50|NONE"
]

def simulate_jinja2(matrix):
    final_vault_configs = []
    vault_index = 1
    
    for line in matrix:
        elements = line.split('|')
        if len(elements) >= 4:
            block_path = elements[0].strip()
            signature = elements[1].strip()
            size_gb = int(elements[2].strip())
            mount_status = elements[3].strip()
            
            # Simulated Debug Banner Output
            print(f"👉 TARGET PATH: [ {block_path} ] | SIZE: {size_gb} GB | TYPE: {signature}")
            if signature == 'crypto_LUKS':
                print("   [ ✓ ] DISCOVERED ENCRYPTED PARTITION -> SKIPPING")
            elif mount_status != 'NONE' or (signature in ['btrfs', 'swap', 'ext4', 'vfat'] and signature != 'EMPTY'):
                print("   [ 🖥️ ] ACTIVE INFRASTRUCTURE OR SYSTEM REVENUE PATH -> SKIPPING")
            else:
                print("   [ ✓ ] UNPROTECTED CLEAN UNALLOCATED SPACE DETECTED -> PROTOCOL ACTIVATED")
                dynamic_moniker = f"secure_vault_{vault_index}"
                final_vault_configs.append({
                    'path': block_path,
                    'name': dynamic_moniker,
                    'size_gb': size_gb,
                    'signature': signature
                })
                vault_index += 1
    return final_vault_configs

res = simulate_jinja2(discovered_raw_storage_matrix)
print("\nFinal Configs Array:", res)

