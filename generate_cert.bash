# Generate TLS certificates

whereweare=$(pwd)
domains="$1"
domainsnow=""

for val in $domains; 
do
	domainsnow="$domainsnow $val"
done

(head nginx.conf -n 13 | sed 's/server_name.*/server_name'"$domainsnow"';/g'; sed -e "1,13d" nginx.conf) > .nginx.conf.tmp
mv .nginx.conf.tmp nginx.conf
if [ -f .nginx.conf ]; 
then
	(head .nginx.conf -n 13 | sed 's/server_name.*/server_name'"$domainsnow"';/g'; sed -e "1,13d" .nginx.conf) > .nginx.conf.tmp
	mv .nginx.conf.tmp .nginx.conf
fi
domainsnow=""

for val in $domains; 
do
        domainsnow="$domainsnow -d $val"
done
docker-compose build certbot
sudo docker-compose run --rm --name certbot_first_generate \
    -v "/etc/letsencrypt:/etc/letsencrypt" \
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
    -v "$whereweare/www/certbot:/var/www/certbot" \
    certbot certbot certonly --webroot -w /var/www/certbot$domainsnow
