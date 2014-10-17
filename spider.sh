#!/bin/bash -u

# url="www.diy-tool.com"
url="${1}"
level="30"

wget --spider -r --level=${level} --no-parent -nv -o wget.log -R jpeg,jpg,gif,ico,css,js,pdf,png,xls -e robots=off --wait 2 "${url}"

grep -ri 'http://' wget.log | grep -E -v '(\.jpg|\.jpeg|\.gif|\.css|\.js|\.pdf|\.png|\.xls)' | awk '{print $3}'|sort|uniq|sort > site_map.txt

cat $1 |grep -i -E -v '(\.jpg|\.jpeg|\.gif|\.css|\.js|\.pdf|\.png|\.xls|\.ico|\.txt|\.doc|yandexbot|googlebot|YandexDirect|\/upload\/|" 404 |" 301 |" 302 )'|perl -MURI::Escape -lne 'print uri_unescape($_)'|grep yandsearch|awk '{print $1}'|sort|uniq|wc -l
