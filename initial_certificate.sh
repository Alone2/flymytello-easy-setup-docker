# Generate TLS certificates for the first time

cp nginx.conf .nginx.conf -f
( head nginx.conf -n 13; echo } ) > .nginx.conf.tmp
mv .nginx.conf.tmp nginx.conf

docker-compose build nginx
docker-compose up -d nginx

sudo echo waiting 30 seconds for webserver...
sleep 30
sudo bash generate_cert.bash $1

sudo chmod 755 nginx.conf
sudo chown $USER nginx.conf
cp .nginx.conf nginx.conf -f
sudo rm .nginx.conf -f 

docker-compose stop nginx
