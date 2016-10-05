#!/bin/bash

function addSite {
    url=${1:-none}
    directory=${2:-none}

    if [[ ${url} == "none" ]] 
        then
        echo "no url specified"
    fi

    echo "<VirtualHost *:80>
    ServerName ${url}
    DocumentRoot ${directory}
    <Directory  \"${directory}/\">
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require local
    </Directory>
</VirtualHost>" >> /c/Website/WampServer/bin/apache/apache2.4.17/conf/extra/httpd-vhosts.conf
    echo "127.0.0.1 ${url}
::1 ${url}
">> /C/WINDOWS/system32/drivers/etc/hosts
}