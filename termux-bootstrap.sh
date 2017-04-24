#!/data/data/com.termux/files/usr/bin/bash

cd $(dirname "$0")
bash <(sed -n '2,$p' bootstrap.sh) "$@"
