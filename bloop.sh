#!/bin/bash
curl -L "$CONFIGINURL" >$(rclone listremotes |grep rclone.conf)
rclone copy 1:brave/bdata1/brav.tar.gz / 
T
cp -r /brav /.config/BraveSoftware/brav
rm -r Brave-Browser
mv brav Brave-Browser
