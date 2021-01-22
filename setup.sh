# clone projects
git clone https://github.com/Alone2/flymytello-server-webrtc-go
git clone https://github.com/Alone2/flymytello-client-react

echo "You need to have a domain for the next step"
echo "Do you want to set up duckdns or use use your own domain"
printf "type 'y' for duckdns: "
read inp
[ "$inp" = "y" ] && (
    echo "Go to duckdns.org and create a new domain."
    echo "Type the name of your sub domain "
    printf "(without .duckdns.org): "
    read sub
    printf "Type your token: "
    read token
    sh generate_confs.sh "${sub}.duckdns.org" 1 "$sub" "$token"
    docker-compose up -d duckdns
    # Set up certs
    sh initial_certificate.sh "${sub}.duckdns.org"
    docker-compose stop duckdns
) || (
    # Read ip
    echo "Type your domain or domains (seperated by space):"
    echo "Example: example.duckdns.org example.com"
    echo
    printf "Domain: "
    read domain

    # Generate nginx config
    sh generate_confs.sh "$domain"
    # Set up certs
    sh initial_certificate.sh "$domain"
)

# Set up password for the server
docker-compose up -d flymytello-server
docker-compose exec flymytello-server "./setup/setup"
docker-compose stop flymytello-server

# Build npm
docker build ./flymytello-client-react -t telloclient
docker run --rm -v $(pwd)/www/flymytelloclient:/app/build -t telloclient
