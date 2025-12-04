#!/bin/bash

# I had to run:
# sed -i 's/\r$//' Apache_Deployment_LHM.sh 
# to fix spacing issues from windows to linux…

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check if the script is run as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root. Use sudo." >&2
        exit 1
    fi
}

# Update and upgrade the server
update_upgrade_server() {
    echo "Updating/upgrading the server and setting timezone to EST..."
    apt update -y && apt upgrade -y
    timedatectl set-timezone EST
}

# Install Apache
install_apache() {
    echo "Installing Apache..."
    apt install apache2 -y
    systemctl enable apache2
    systemctl start apache2
}

# Configure UFW for SSH and Apache, then enable it
configure_firewall() {
    echo "Configuring UFW for SSH and Apache..."
    ufw allow OpenSSH
    ufw allow 'Apache Full'
    echo "Enabling UFW..."
    ufw --force enable
}

# Create /backup directory
create_backup_directory() {
    echo "Creating /backup directory..."
    mkdir -p /backup
}

# Create log files
create_log_files() {
    echo "Creating log files..."
    touch /var/log/html-backup.log
    touch /var/log/my_updates_file.log
}

# Update crontab with tasks
update_crontab() {
    echo "Updating crontab..."
    (crontab -l 2>/dev/null || true; echo "") > temp_crontab
    cat <<EOF >> temp_crontab
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
#
# These are my additions:
# Conduct daily updates & upgrades at 2 a.m.
0 2 * * * apt update && apt upgrade -y >> /var/log/my_updates_file.log 2>&1
# Conduct monthly dist-upgrades at 2:30 a.m.
30 2 1 * * apt dist-upgrade -y >> /var/log/my_updates_file.log 2>&1
# Backup the html folder on the first day of the month at 3 a.m.
0 3 1 * * tar -czf /backup/html-backup-\$(date +\%Y-\%m).tar.gz /var/www/LHM.com >> /var/log/html-backup.log 2>&1
# Remove backups older than 180 days
0 3 1 * * find /backup/ -type f -name "html-backup-*.tar.gz" -mtime +180 -exec rm {} \; >> /var/log/html-backup.log 2>&1
# Conduct a nightly restart at 3:30 a.m.
30 3 * * * /sbin/shutdown -r now
EOF
    crontab temp_crontab
    rm temp_crontab
}

# Modify Apache configuration (apache2.conf)
modify_apache_main_config() {
    echo "Modifying Apache main configuration..."

    # Backup the original configuration file
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak

    # Modify only lines where "FollowSymLinks" appears after "Indexes"
    sed -i '/Indexes.*FollowSymLinks/ s/Indexes/-Indexes/' /etc/apache2/apache2.conf
    sed -i '/Indexes.*FollowSymLinks/ s/FollowSymLinks/+FollowSymLinks/' /etc/apache2/apache2.conf

    # Restart Apache to apply the changes
    systemctl restart apache2
}


# Modify Apache security configuration (security.conf)
modify_apache_security_config() {
    echo "Modifying Apache security configuration..."
    cp /etc/apache2/conf-enabled/security.conf /etc/apache2/conf-enabled/security.conf.bak
    sed -i 's/^ServerTokens .*/ServerTokens Prod/' /etc/apache2/conf-enabled/security.conf
    sed -i 's/^ServerSignature .*/ServerSignature Off/' /etc/apache2/conf-enabled/security.conf
    systemctl restart apache2
}

# Create a simple "Hello, World" web page
create_hello_world_page() {
    echo "Creating a simple 'Hello, World' web page..."

    # Define the HTML content
    local html_content="<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Hello World</title>
</head>
<body>
    <h1>Hello, Worldly Traveler!!</h1>
    <p>Welcome to your newly configured Apache server!</p>
</body>
</html>"

    # Write the content to /var/www/LHM.com/index.html
    echo "$html_content" > /var/www/LHM.com/index.html

    # Set appropriate permissions
    chown www-data:www-data /var/www/LHM.com/index.html
    chmod 644 /var/www/LHM.com/index.html

    echo "Web page created at /var/www/LHM.com/index.html."
}

# Enable SSL and run LetsEncrypt
enable_ssl() {
    echo "Enable SSL and run certificates.."

    # Enable SSL
    sudo a2enmod ssl -q
    sudo systemctl restart apache2
    sleep 10

    # Run certbot for LetsEncrypt
    snap install --classic certbot
    ln -s /snap/bin/certbot /usr/bin/certbot
    certbot --apache -d lefthandyman.com -d www.lefthandyman.com

    echo "Pausing for 5 Seconds"
    sleep 2
    echo "Pausing for 3 Seconds"
    sleep 1
    echo "Pausing for 2 Seconds"
    sleep 1
    echo "Pausing for 1 Seconds"
    sleep 1
}

# Main function
main() {
    check_root
    update_upgrade_server
    install_apache
    configure_firewall
    create_backup_directory
    create_log_files
    update_crontab
    modify_apache_main_config
    modify_apache_security_config
    create_hello_world_page
    enable_ssl 
    
    echo "Server setup completed successfully!"
}

main
