# Install nginx
apt-get -y install nginx

# Generate certificate:
TMP_DIR=$(mktemp -d)
cd $TMP_DIR
FQDN=properssl.example.com
sh /mnt/bootstrap/gen-self-signed.sh "$FQDN" server
echo "Generated key file and self signed certificate for $FQDN"
mv server.key server.crt /etc/ssl/private

# Setup nginx site
rm -f /etc/nginx/sites-enabled/default
cp /mnt/bootstrap/ssl-pfs-site.conf /etc/nginx/sites-available/ssl-pfs-site
ln -s -f /etc/nginx/sites-available/ssl-pfs-site /etc/nginx/sites-enabled/ssl-pfs-site

# Restart nginx
service nginx restart

cat << _EOF_
Installation complete. You should be able to access the server at:

   http://localhost:10080/

   Or,

   https://localhost:10443/

_EOF_
