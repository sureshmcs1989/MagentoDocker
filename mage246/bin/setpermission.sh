echo "setup setup permissions..."
docker exec -it web246 chmod -R 777 /var/www/src/var
docker exec -it web246 chmod -R 777 /var/www/src/pub
docker exec -it web246 chmod -R 777 /var/www/src/generated

  
