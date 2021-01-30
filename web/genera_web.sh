#!/bin/bash

sed -i -e 's/Welcome\ to\ nginx/'Welcome\ to\ ${name}'/g' /var/www/html/index.nginx-debian.html