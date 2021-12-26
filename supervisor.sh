#!/bin/bash
#aadon-stat
cat /brav/conf.d/websockify.sh |sed 's/5900/5901/g' > /system/conf.d/websockify.sh
#adon-end
set -ex
exec supervisord -c /system/supervisord.conf
