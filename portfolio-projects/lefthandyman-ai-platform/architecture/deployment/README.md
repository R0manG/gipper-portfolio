<div align="center">

# 🦖 Phase 1 — Website Modernization  
### UX, Responsiveness, Layout, Performance, and Accessibility

![Phase](https://img.shields.io/badge/phase-1-blue)
![Focus](https://img.shields.io/badge/focus-UX%20%7C%20Performance%20%7C%20Responsiveness-green)

---

</div>
🛠️ Deployment & Server Hardening Guide

Lefthandyman Website — Ubuntu + Apache + Let's Encrypt
Version: Current-State (Phase 1)

📘 Overview

This document describes the server setup, deployment process, security hardening, cron automation, and recovery procedures for the current Lefthandyman website.

The system runs on:

- OS: Ubuntu Server
- Web Server: Apache
- TLS: Let’s Encrypt via Certbot
- Hosting: On-Premise
- Root Website Directory: /var/www/LHM.com
- Automation Script: Apache_Deployment_LHM.sh (included in this repository) 

Apache_Deployment_LHM

This setup provides a repeatable way to bootstrap a new server, rebuild a damaged one, or recover from data loss.

📦 1. Server Setup Script Summary

The deployment script performs the following high-level functions:

🔧 System Prep

- Ensures the script is run as root
- Updates & upgrades system packages
- Sets timezone to EST

🌐 Apache Installation & Setup

- Installs Apache
- Enables and starts the service
- Configures /var/www/LHM.com as the working directory
- Creates a test index.html page

🔥 Firewall Hardening

- Configures UFW to allow:
- SSH (OpenSSH)
- Apache Full (HTTP + HTTPS)
- Enables UFW with non-interactive mode

💾 Backups & Logging

Creates:

- /backup directory
- /var/log/html-backup.log (HTML backups)
- /var/log/my_updates_file.log (system updates)

⏱️ Cron Automation

Sets scheduled tasks:

- Daily updates & upgrades @ 02:00
- Monthly dist-upgrade @ 02:30
- Monthly HTML backup @ 03:00
- Monthly prune backups >180 days
- Nightly reboot @ 03:30

These cron tasks ensure automatic patching, backups, and system refresh.

🔐 Apache Hardening

Modifies:

- /etc/apache2/apache2.conf
- /etc/apache2/conf-enabled/security.conf

Hardening includes:

- Disabling directory listing
- Setting ServerTokens Prod
- Setting ServerSignature Off

🔒 SSL / HTTPS Setup (Let’s Encrypt)

The script:

- Enables Apache SSL module

- Installs Certbot via Snap

- Retrieves certificates for:

  - lefthandyman.com

  - www.lefthandyman.com

This provides strong modern TLS security.

📁 2. Directory Structure

Key directories involved in deployment:

/var/www/LHM.com         # Root website folder
/backup                  # Monthly HTML backups
/var/log/html-backup.log # Backup logging
/var/log/my_updates_file.log # Update logs
/etc/apache2/apache2.conf # Main Apache config (backed up automatically)
/etc/apache2/conf-enabled/security.conf # Security config (backed up automatically)

🚀 3. Deployment Process (Manual)

Phase 1 uses manual deployment.

Step 1 — Update site files

Copy the latest website files (HTML, CSS, images) from local development machine:

- scp -r ./site_files/* user@yourserver:/var/www/LHM.com/

Step 2 — Fix permissions

- sudo chown -R www-data:www-data /var/www/LHM.com
- sudo chmod -R 755 /var/www/LHM.com

Step 3 — Validate

Check from a browser:

- https://lefthandyman.com

🔁 4. Re-running the Script

You can re-run the script, but note:
- index.html will be overwritten by the "Hello World" test file
- Cron entries will be reinstalled (non-idempotent)
- Apache configs will be re-hardened

Best practice:
Use the script only for first-time provisioning or full rebuilds, not day-to-day updates.

🧯 5. DRP / COOP (Disaster Recovery)
Scenario A — Website content corrupted

1. SSH into server
2. List available backups:

- ls /backup/html-backup-*.tar.gz

3. Restore latest backup:

- sudo tar -xzf /backup/html-backup-YYYY-MM.tar.gz -C /var/www/

4. Restore permissions
5. Validate site

Scenario B — Full server failure / new hardware

1. Install/overwrite with fresh Ubuntu Server 
2. Copy Apache_Deployment_LHM.sh to new machine
3. Run:

- chmod +x Apache_Deployment_LHM.sh
- sudo ./Apache_Deployment_LHM.sh

4. Restore /backup from off-server storage
5. Validate site & DNS

Scenario C — SSL Certificate Expiration

Renew manually (if needed):
- sudo certbot renew --dry-run

Scenario D — Firewall lockout or misconfiguration

1. Allow SSH:

- sudo ufw allow OpenSSH
- sudo ufw reload

2. Reset UFW if required:

- sudo ufw reset
- sudo ufw --force enable

🔭 6. Known Limitations (Prior to Cloud Migration)

- No CDN or caching layer
- No load balancing
- Dependent on on-premise internet uptime
- Manual deployments (no CI/CD yet)
- Backups all stored locally (no offsite copy yet)

These items will be resolved in Phase 3 – Cloud Migration.

📌 7. Script Location in Repository
architecture/deployment/Apache_Deployment_LHM.sh

This script is referenced as the authoritative automation source.
Full script content is available with inline comments for traceability:

🏁 8. Next Steps (Phase 1 → Phase 2)

- Convert deployment process into a documented version-controlled system
- Add offsite backup replication (optional)
- Establish CI/CD pipeline for future cloud platform
- Begin cloud architecture planning for Phase 3
