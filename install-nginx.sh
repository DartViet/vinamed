#!/bin/bash

# Script to install nginx on Ubuntu and configure it with custom config
# Run with sudo privileges

set -e  # Exit on any error

# Configuration variables
DOMAIN="ltd.zapto.org"
EMAIL="dngo10@outlook.com"

echo "Starting nginx installation and configuration..."
echo "Domain: $DOMAIN"
echo "Email: $EMAIL"

#####################################################################
######################## Install and configure nginx ################
#####################################################################

# Update package lists
echo "Updating package lists..."
apt-get update

# Install nginx
echo "Installing nginx..."
apt-get install -y nginx

# Install and configure UFW firewall
echo "Installing UFW firewall..."
apt-get install -y ufw

echo "Configuring UFW firewall rules..."
# Reset UFW to default settings
ufw --force reset

# Set default policies
ufw default deny incoming
ufw default allow outgoing

# Allow SSH (port 22)
ufw allow ssh

# Allow HTTP (port 80)
ufw allow 80/tcp

# Allow HTTPS (port 443)
ufw allow 443/tcp

# Enable UFW
echo "Enabling UFW firewall..."
ufw --force enable

# Show UFW status
echo "UFW firewall status:"
ufw status verbose

# Stop nginx service temporarily
echo "Stopping nginx service..."
systemctl stop nginx

# Create backup of original nginx.conf
echo "Creating backup of original nginx.conf..."
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup.$(date +%Y%m%d_%H%M%S)

# Create certs directory if it doesn't exist
echo "Creating SSL certificates directory..."
mkdir -p /etc/nginx/certs

# Generate self-signed SSL certificate (for development)
echo "Generating self-signed SSL certificate..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/certs/nginx.key \
    -out /etc/nginx/certs/nginx.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=localhost"

# Set proper permissions for SSL files
chmod 600 /etc/nginx/certs/nginx.key
chmod 644 /etc/nginx/certs/nginx.crt

# Copy custom nginx configuration
echo "Copying custom nginx configuration..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/nginx/nginx.conf" /etc/nginx/nginx.conf

# Test nginx configuration
echo "Testing nginx configuration..."
nginx -t

# Enable nginx to start on boot
echo "Enabling nginx service..."
systemctl enable nginx

# Start nginx service
echo "Starting nginx service..."
systemctl start nginx

# Check nginx status
echo "Checking nginx status..."
systemctl status nginx --no-pager

# Show listening ports
echo "Nginx is now listening on the following ports:"
ss -tlnp | grep nginx


##############################################################################
####################### Install and configure Certbot ########################
##############################################################################

# Install and configure Certbot for Let's Encrypt SSL
echo ""
echo "Installing Certbot for Let's Encrypt SSL certificates..."

# Stop nginx service before certbot installation
echo "Stopping nginx service for certbot installation..."
systemctl stop nginx

# Install snapd (required for certbot)
apt-get install -y snapd
snap install core; snap refresh core

# Install certbot
snap install --classic certbot

# Create symlink for certbot command
ln -sf /snap/bin/certbot /usr/bin/certbot

# Generate Let's Encrypt certificate for the domain
echo "Generating Let's Encrypt certificate for $DOMAIN..."
certbot certonly --standalone \
    --non-interactive \
    --agree-tos \
    --email $EMAIL \
    --domains $DOMAIN

# Update nginx configuration to use Let's Encrypt certificates
echo "Updating nginx configuration to use Let's Encrypt certificates..."
sed -i 's|/etc/nginx/certs/nginx.crt|/etc/letsencrypt/live/'$DOMAIN'/fullchain.pem|g' /etc/nginx/nginx.conf
sed -i 's|/etc/nginx/certs/nginx.key|/etc/letsencrypt/live/'$DOMAIN'/privkey.pem|g' /etc/nginx/nginx.conf

# Test nginx configuration with new certificates
echo "Testing nginx configuration with Let's Encrypt certificates..."
nginx -t

# Re-enable and start nginx with new certificates
echo "Re-enabling and starting nginx with Let's Encrypt certificates..."
systemctl enable nginx
systemctl start nginx

# Set up automatic certificate renewal
echo "Setting up automatic certificate renewal..."
# Stop nginx service to ensure certbot can bind to port 80
systemctl stop nginx
# Test the renewal process
certbot renew --dry-run

# Create renewal hook to reload nginx
mkdir -p /etc/letsencrypt/renewal-hooks/deploy
cat > /etc/letsencrypt/renewal-hooks/deploy/nginx-reload.sh << 'EOF'
#!/bin/bash
systemctl reload nginx
EOF
chmod +x /etc/letsencrypt/renewal-hooks/deploy/nginx-reload.sh

# Create systemd timer for automatic renewal (runs twice daily)
cat > /etc/systemd/system/certbot-renewal.service << 'EOF'
[Unit]
Description=Certbot Renewal
After=network.target

[Service]
Type=oneshot
ExecStart=/snap/bin/certbot renew --quiet
User=root
EOF

cat > /etc/systemd/system/certbot-renewal.timer << 'EOF'
[Unit]
Description=Run certbot twice daily
Requires=certbot-renewal.service

[Timer]
OnCalendar=*-*-* 00:00:00
OnCalendar=*-*-* 12:00:00
RandomizedDelaySec=3600
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Enable and start the renewal timer
systemctl daemon-reload
systemctl enable certbot-renewal.timer
systemctl start certbot-renewal.timer

# Show timer status
echo "Checking automatic renewal timer status..."
systemctl status certbot-renewal.timer --no-pager

# Restart nginx service to apply changes
systemctl start nginx

echo ""
echo "✅ Let's Encrypt SSL certificate installed successfully!"
echo "   Domain: $DOMAIN"
echo "   Certificate location: /etc/letsencrypt/live/$DOMAIN/"
echo "   Auto-renewal configured"

# Install and configure NoIP Dynamic DNS client
echo ""
echo "Installing NoIP Dynamic DNS client..."

# Install build essentials including GCC for compiling NoIP client
echo "Installing build essentials (gcc, make, etc.)..."
apt-get install -y build-essential

#################################################################################
######################## Install NoIP Dynamic DNS Client ########################
#################################################################################

# Stop NoIP service if running
echo "Stopping NoIP service if running..."
systemctl stop noip || true

# Download NoIP client
cd /tmp
wget https://www.noip.com/client/linux/noip-duc-linux.tar.gz

# Extract and compile NoIP client
tar xzf noip-duc-linux.tar.gz
cd noip-2.1.9-1/
make install

# Create NoIP service file
cat > /etc/systemd/system/noip.service << 'EOF'
[Unit]
Description=NoIP Dynamic DNS Update Client
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/bin/noip2
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# Setup NoIP client configuration
echo "Configuring NoIP client..."


# Reload systemd and enable NoIP service
systemctl daemon-reload
systemctl enable noip

echo ""
echo "⚠️  NoIP client installed but not configured yet!"
echo "   To configure NoIP, run: sudo /usr/local/bin/noip2 -C"
echo "   Then start the service: sudo systemctl start noip"
echo "   You'll need your NoIP account credentials during configuration."

# Clean up downloaded files
rm -rf /tmp/noip-duc-linux.tar.gz /tmp/noip-2.1.9-1/



echo ""
echo "✅ Nginx installation and configuration completed successfully!"
echo ""
echo "📋 Summary:"
echo "   - Nginx installed and configured"
echo "   - UFW firewall configured (ports 22, 80, 443 allowed)"
echo "   - Let's Encrypt SSL certificate installed for $DOMAIN"
echo "   - Custom configuration applied from ./nginx/nginx.conf"
echo "   - Backup of original config saved to /etc/nginx/nginx.conf.backup.*"
echo "   - Service enabled to start on boot"
echo "   - NoIP client installed (requires manual configuration)"
echo "   - Automatic SSL certificate renewal configured (twice daily)"
echo ""
echo "🔧 Next steps:"
echo "   - Configure NoIP: sudo /usr/local/bin/noip2 -C"
echo "   - Start NoIP service: sudo systemctl start noip"
echo "   - Make sure your backend services (hapi on :8080, pocketbase on :8081) are running"
echo "   - Access your services via https://$DOMAIN (with valid SSL certificate)"
echo "   - Check logs with: sudo journalctl -u nginx -f"
echo "   - Check NoIP logs with: sudo journalctl -u noip -f"
echo "   - Check certificate renewal: sudo certbot renew --dry-run"
echo ""
echo "⚠️  Note: This uses a self-signed certificate. Your browser will show a security warning."
echo "   For production, replace with a proper SSL certificate."
