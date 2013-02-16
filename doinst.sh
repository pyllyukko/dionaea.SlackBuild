config() {
  NEW="\$1"
  OLD="\$(dirname \$NEW)/\$(basename \$NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r \$OLD ]; then
    mv \$NEW \$OLD
  elif [ "\$(cat \$OLD | md5sum)" = "\$(cat \$NEW | md5sum)" ]; then
    # toss the redundant copy
    rm \$NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}
# fix the paths in the config file
sed -i 's:"var/:"${LOCALSTATEDIR}/:' opt/dionaea/etc/dionaea/dionaea.conf.new

config opt/dionaea/etc/dionaea/dionaea.conf.new
( cd opt/dionaea/lib/dionaea/python/dionaea ; rm -rfv pyev.so )
( cd opt/dionaea/lib/dionaea/python/dionaea ; ln -sfv /opt/dionaea/lib/dionaea/python.so pyev.so )
( cd opt/dionaea/lib/dionaea/python/dionaea ; rm -rfv core.so )
( cd opt/dionaea/lib/dionaea/python/dionaea ; ln -sfv /opt/dionaea/lib/dionaea/python.so core.so )
