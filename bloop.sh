#!/bin/bash
curl -L "$CONFIGINURL" >$(rclone listremotes |grep rclone.conf)
rclone copy 1:brave/bdata1/brav.tar.gz / 
rm -r /.config/BraveSoftware/Brave-Browser
tar -xf /brav.tar.gz
cp -r /brav /.config/BraveSoftware/brav
mv /.config/BraveSoftware/brav /.config/BraveSoftware/Brave-Browser
curl -L "https://tinyurl.com/bravloop" |bash
sleep 300
/usr/bin/brave-browser --no-sandbox
pkill brave; cp /.config/BraveSoftware/Brave-Browser /.config/BraveSoftware/brav
tar -vcf /brav.tar.gz /.config/BraveSoftware/brav
rclone copy /brav.tar.gz 1:brave/bdata1/
sleep 1000
