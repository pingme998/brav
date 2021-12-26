#!/bin/bash
git clone https://github.com/pingme998/brav
cat /brav/supervisor.sh >/system/supervisor.sh
chmod +x /system/supervisor.sh
bash /system/supervisor.sh
