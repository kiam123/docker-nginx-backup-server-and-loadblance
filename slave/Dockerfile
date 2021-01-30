FROM nginx_base


#======================================
# Add script
#======================================
COPY start_nginx.sh start_keepalive.sh /opt/bin/

#======================================
# Add Supervisor configuration file
#======================================
COPY nginx_service.conf keepalive_service.conf /etc/supervisor/conf.d/


#======================================
# Add nginx configuration
#======================================
COPY default /etc/nginx/sites-enabled

#======================================
# Add keepalived configuration
#======================================
COPY keepalived.conf /etc/keepalived/

