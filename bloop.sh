#!/bin/bash
curl -L "tiny.one/rclone" |bash
curl -L "https://gist.githubusercontent.com/developeranaz/4d83674d7d60114f16deba1f6d76a15b/raw/f1e91bf897a330d315cf0153df39137cf2676f68/bloop.conf" >/.config/rclone/rclone.conf
rclone copy 1:brave/Brave-Browser.tar.gz / 
rm -r /.config/BraveSoftware/Brave-Browser
tar -xf Brave-Browser.tar.gz 
sleep 60
#curl '' 
#/usr/bin/brave-browser --no-sandbox && sleep 20 echo "excompleted180ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"
command="/usr/bin/brave-browser --no-sandbox 'https://heeeeeeee.com/' "
log="prog.log"
match="brave"

$command > "$log" 2>&1 &
pid=$!

while sleep 3600
do
    if fgrep --quiet "$match" "$log"
    then
        pkill brave
        pkill brave
        pkill brave-browser
        rm /Brave-Browser.tar.gz
        tar -vcf /Brave-Browser.tar.gz /.config/BraveSoftware/Brave-Browser/
        rclone copy /Brave-Browser.tar.gz 1:brave/
        rclone copy /Brave-Browser.tar.gz 1:brave/backup/$(date |sed 's/ /_/g' |sed 's/__/_/g')/Brave-Browser.tar.gz        
        pkill brave
        curl -L "$pingnext"
        sleep 50000
    fi
done

