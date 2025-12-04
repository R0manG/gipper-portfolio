<div align="center">

# 🦖 Phase 1 — Website Modernization  
### UX, Responsiveness, Layout, Performance, and Accessibility

![Phase](https://img.shields.io/badge/phase-1-blue)
![Focus](https://img.shields.io/badge/focus-UX%20%7C%20Performance%20%7C%20Responsiveness-green)

---

</div>

# Current Hosting Architecture — Lefthandyman

## 1. Overview

The Lefthandyman website is currently hosted on a self-managed server in a home network.

- **Host:** Raspberry Pi, running Ubuntu Server
- **OS:** Ubuntu Server (ARM)
- **Web server:** Apache HTTP Server
- **Domain:** lefthandyman.com
- **Registrar/DNS:** Network Solutions (The artist formerly known as Domain.com)
- **TLS/HTTPS:** Enabled via Let's Encrypt using Certbot
- **Site type:** Static website (HTML, CSS, images)

Traffic flows from the public internet, through the domain registrar/DNS, to the hosting router, and then to the Ubuntu + Apache server that serves the website content.

---

## 2. Network & Data Flow (Text Description)

1. A customer enters `lefthandyman.com` in their browser.
2. DNS for `lefthandyman.com` resolves to the public IP address of the hosting environment.
3. The router forwards HTTP/HTTPS traffic (ports 80/443) to the internal Ubuntu server (Raspberry Pi).
4. Apache on the server handles the incoming request:
   - Serves static HTML/CSS/image files.
   - Applies Apache configuration (security, directory options, etc.).
5. The response is returned to the customer’s browser over HTTPS.

---

## 3. Key Components

### 3.1 Server

- Ubuntu Server on a small form-factor host (e.g., Raspberry Pi).
- Apache installed and enabled as a system service.
- UFW (Uncomplicated Firewall) configured to allow:
  - Web Traffic (ports 80 and 443)
- Automatic updates and backups configured by a custom shell script.

### 3.2 Web Server (Apache)

- Serves content from ubuntu server.
- Directory listing disabled
- Secure server best practices configured
- SSL module enabled and managed via Certbot (Let’s Encrypt) to issue and renew certificates.

### 3.3 Backups & Maintenance

A custom script:

- Updates and upgrades the system packages.
- Configures cron to:
  - Run daily `apt update && apt upgrade -y`.
  - Run monthly `apt dist-upgrade -y`.
  - Back up web pages & content monthly to specified backup folder location with timestamped `.tar.gz` archives.
  - Prune backups older than 180 days.
- Creates log files for updates and HTML backups.

These tasks provide a level of maintenance, backup, and recoverability.

---

## 4. Security & Reliability Characteristics

### Strengths

- End-to-end control of hosting environment.
- No recurring cloud hosting cost.
- Automatic OS updates and regular backups for web content
- Apache hardened via:
  - Disabled directory indexes
  - Reduced server signature
  - HTTPS enabled with Let’s Encrypt

### Limitations

- Single point of failure (one server, one location).
- No CDN or global edge caching.
- No load balancing or horizontal scaling.

---

## 5. Alignment with Future Phases

This current-state architecture is **sufficient for Phase 1**, where the focus is UX modernization and performance on the existing stack.

In **Phase 3**, this document will serve as the baseline for:

- Cloud migration design (e.g., Cloud Run, Firebase Hosting, or similar).
- Future-state architecture diagram.
- Reliability and scalability improvements (CDN, managed TLS, logging, monitoring).

