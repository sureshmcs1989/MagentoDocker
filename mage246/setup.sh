echo "==Initiate magento setup=="
echo "==Download magento Package=="
#docker cp ./docker/auth.json magento246-web:/usr/bin/composer/auth.json
docker exec -it web246 download-magento
echo "==Copy custom nginx.conf file into docker container =="
docker cp ./docker/nginx/nginx.conf web246:/etc/nginx/nginx.conf
docker exec -it web246 install-magento
echo "===Magento installation is completed==="
echo "Executed file permision are set below files"
echo "reindex.sh"
chmod +x ./bin/reindex.sh
echo "scd.sh"
chmod +x ./bin/scd.sh
echo "setpermission.sh"
chmod +x ./bin/setpermission.sh
echo "setup_upgrade.sh"
chmod +x ./bin/setup_upgrade.sh
echo "clear_cache.sh"
chmod +x ./bin/clear_cache.sh
echo -e "\e[1;45m Frontend URL : \e[0m \e[1;32m http://magento-dev:8080/ \e[0m"
echo -e "\e[1;45m Backend URL : \e[0m \e[1;32m http://magento-dev:8080/admin \e[0m"
echo -e "\e[1;45m Admin User Name : \e[0m \e[1;32m admin \e[0m"
echo -e "\e[1;45m Admin Password : \e[0m \e[1;32m admin@123 \e[0m"
echo -e "Add host entry to windows Machine execute below command to the Command Prompt or Powershell 
       \e[1;32m Reference link : https://www.hostinger.in/tutorials/how-to-edit-hosts-file"
echo "echo 127.0.0.1 magento-dev >> C:\Windows\System32\drivers\etc\hosts"
