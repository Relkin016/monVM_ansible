sudo docker compose -f env/docker-compose_blue.yml up -d
sudo docker compose -f env/docker-compose_green.yml up -d
sudo docker compose -f shared/docker-compose.yml up -d

