FROM nginx_base


#======================================
# Add Node web
#======================================
COPY index.nginx-debian1 index.nginx-debian2 /


#======================================
# Add script
#======================================
COPY start_nginx.sh genera_web.sh /opt/bin/
RUN chmod +x /opt/bin/genera_web.sh

#======================================
# Add Supervisor configuration file
#======================================
COPY nginx_service.conf genera_service.conf /etc/supervisor/conf.d/

ENV name=Node1
