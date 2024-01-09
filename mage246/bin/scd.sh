echo "Running static content deployment process..."
docker exec -it web246 bin/magento setup:static-content:deploy -f
echo "Completed"
  
