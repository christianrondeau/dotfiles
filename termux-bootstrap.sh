#!/data/data/com.termux/files/usr/bin/bash

cd $(dirname "$0")
apt install termux-tools termux-api
bash <(sed -n '2,$p' bootstrap.sh) "$@"
