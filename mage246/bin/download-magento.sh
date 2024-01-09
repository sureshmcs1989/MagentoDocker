#!/usr/bin/env bash
cd /var/www/src

composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.4.5-p3 .
#composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition magento 2.4.6-p2

find . -type f -exec chmod 644 {} \;            
find . -type d -exec chmod 755 {} \;        
chmod -Rf 777 var
chmod -Rf 777 pub/static
chmod -Rf 777 pub/media
chmod 777 ./app/etc
chmod 644 ./app/etc/*.xml
chmod -Rf 775 bin