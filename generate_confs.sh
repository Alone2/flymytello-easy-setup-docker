DOMAIN="$1"
DUCKDNSENABLED="$2"
SUBDOMAIN="$3"
TOKEN="$4"

echo "events {}

http {
    server {
        listen 80;
        server_name $DOMAIN;
        location /.well-known/acme-challenge/ {
            root /var/www/certbot;
        }
        location / {
            return 301 https://\$host\$request_uri;
        }    
    }
    server {
        listen 443 ssl;
        server_name $DOMAIN;
        ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
        include mime.types;
        index index.html;
        location / {
            root /var/www/flymytelloclient;
        }
    }
}" > nginx.conf

echo "PUBLIC_CHAIN_CERT=/etc/letsencrypt/live/$DOMAIN/fullchain.pem
PRIVATE_KEY_CERT=/etc/letsencrypt/live/$DOMAIN/privkey.pem" > certificate.env

[ $DUCKDNSENABLED ] && (
    echo "TZ=Europe/London
SUBDOMAINS=$SUBDOMAIN
TOKEN=$TOKEN" > duckdns.env
) || (
    echo "" > duckdns.env
)
