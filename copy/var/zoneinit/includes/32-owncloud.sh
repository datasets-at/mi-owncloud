
log "generating ssl certs"
/opt/local/etc/nginx/sslgen.sh

log "enabling http services"
svcadm enable nginx
svcadm enable php-fpm
svcadm enable memcached

log "Creating OwnCloud DB"

OWNC_PW=$(od -An -N4 -x /dev/random | head -1 | tr -d ' ');

echo "CREATE USER owncloudadmin WITH PASSWORD '$OWNC_PW';" >> /tmp/ownc.sql
echo "CREATE DATABASE owncloud;" >> /tmp/ownc.sql
echo "GRANT ALL PRIVILEGES ON DATABASE owncloud to owncloudadmin;" >> /tmp/ownc.sql

log "Injecting OwnCloud SQL"
sudo PGPASSWORD="postgres" -u postgres /opt/local/bin/psql -w -U postgres < /tmp/ownc.sql

log "determine the webui address for the motd"

WEBUI_ADDRESS=$PRIVATE_IP

if [[ ! -z $PUBLIC_IP ]]; then
        WEBUI_ADDRESS=$PUBLIC_IP
fi

rm /tmp/ownc.sql

gsed -i "s/%WEBUI_ADDRESS%/${WEBUI_ADDRESS}/" /etc/motd
gsed -i "s/%ONC_PW%/${OWNC_PW}/" /etc/motd