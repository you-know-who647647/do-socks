#!/bin/bash
set -e
to_copy_exec=( "create-do-socks-droplet.rb" "destroy-do-socks-droplet.rb" "get-do-socks-info.rb" )
mkdir -p "/tmp/do-socks"
for src_file in "${to_copy_exec[@]}"
do
  dest_file=`echo "${src_file}" | cut -d "." -f 1`
  cp "${src_file}" "/tmp/do-socks/${dest_file}"
  chmod 755 "/tmp/do-socks/${dest_file}"
done

cp "conf.yaml" "/tmp/do-socks/conf.yaml"
rm -rf "/usr/local/bin/do-socks"
mv -f "/tmp/do-socks" "/usr/local/bin"

echo "Installed to /usr/local/bin/do-socks. Please add /usr/local/bin/do-socks to your PATH"
