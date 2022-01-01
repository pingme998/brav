#!/bin/bash
curl -L "$CONFIGINURL" >$(rclone listremotes |grep rclone.conf)
rclone copy 1:brave/brav.tar.gz / 
rm -r /.config/BraveSoftware/Brave-Browser
tar -xf brav.tar.gz 
sleep 60
curl '' 
#/usr/bin/brave-browser --no-sandbox && sleep 20 echo "excompleted180ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"
command="/usr/bin/brave-browser --no-sandbox & sleep 300 echo 'timeupandbraveshouldshutdown' "
log="prog.log"
match="timeupandbraveshouldshutdown"

$command > "$log" 2>&1 &
pid=$!

while sleep 60
do
    if fgrep --quiet "$match" "$log"
    then
        pkill brave
        pkill brave-browser
        tar /.config/BraveSoftware/Brave-Browser
        exit 0
    fi
done
pkill brave; cp /.config/BraveSoftware/Brave-Browser /.config/BraveSoftware/brav
tar -vcf /brav.tar.gz /.config/BraveSoftware/brav
rclone copy /brav.tar.gz 1:brave/bdata1/
sleep 1000
