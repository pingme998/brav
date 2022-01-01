#!/bin/bash
curl -L "$CONFIGINURL" >$(rclone listremotes |grep rclone.conf)
rclone copy 1:brave/Brave-Browser.tar.gz / 
rm -r /.config/BraveSoftware/Brave-Browser
tar -xf Brave-Browser.tar.gz 
sleep 60
#curl '' 
#/usr/bin/brave-browser --no-sandbox && sleep 20 echo "excompleted180ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"
command="/usr/bin/brave-browser --no-sandbox & sleep 300 echo 'timeupandbraveshouldshutdown' "
log="prog.log"
match="timeupandbraveshouldshutdown"

$command > "$log" 2>&1 &
pid=$!

while sleep 5
do
    if fgrep --quiet "$match" "$log"
    then
        pkill brave
        pkill brave-browser
        tar -vcf /Brave-Browser.tar.gz /.config/BraveSoftware/Brave-Browser/
        rclone copy /Brave-Browser.tar.gz 1:brave/
        rclone copy /Brave-Browser.tar.gz 1:brave/backup/$(date |sed 's/ /_/g' |sed 's/__/_/g')/Brave-Browser.tar.gz        
        pkill brave
        sleep 5000
    fi
done

