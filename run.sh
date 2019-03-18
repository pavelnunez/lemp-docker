#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace
# shellcheck disable=SC1091

# Load libraries
. /liblog.sh
. /libnginx.sh

# Load NGINX environment variables
eval "$(nginx_env)"

info "** Starting NGINX **"
if am_i_root; then
    exec gosu "$NGINX_DAEMON_USER" "$NGINX_BASEDIR/sbin/nginx" -c "$NGINX_CONFDIR/nginx.conf" -g "daemon off;"
else
    exec "$NGINX_BASEDIR/sbin/nginx" -c "$NGINX_CONFDIR/nginx.conf" -g "daemon off;"
fi
