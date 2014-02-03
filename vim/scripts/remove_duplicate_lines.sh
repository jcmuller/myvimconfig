#!/bin/sh

for i in `find  . \( -name '*html*' -or -name '*.rb' -or -name '*css' -or -name '*sass' -or \

  -name '*.feature' \) -type f \! \( -path '*.git*' -or -path '*tmp*' -or -path '*solr*' -or \
  -path '*/log/*' -or -path '*/public/*' -or -path '*/vendor/*' \)`
do
  echo "Processing ${i}..."
  cat -s "$i" > "$i.work"; mv "$i.work" "$i" # remove mulptiple lines empty within file
  awk '/^$/ {nlstack=nlstack "\n";next;} {printf "%s",nlstack; nlstack=""; print;}' "$i" > "$i.work"; mv "$i.work" $i  # only one new line character at EOF
done
