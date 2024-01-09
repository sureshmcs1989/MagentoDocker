echo "Running index process..."
docker exec -it web246 bin/magento indexer:reindex
echo "Completed"
  
