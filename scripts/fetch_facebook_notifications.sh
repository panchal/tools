#!/bin/sh

if [ $# -lt 3 ] ; then
  echo "Please check arguments."
  echo "USAGE: fetch_facebook_notifications.sh \$ID \$VIEWER \$KEY \$HEADARG";
  exit 1;
fi

URL="http://www.facebook.com/feeds/notifications.php?id=$1&viewer=$2&key=$3&format=rss20"

if [ $# -eq 4 ] ; then
  headarg=$(( $4 * 2 ))
else
  headarg="-8"
fi

curl --silent "$URL" | grep -E '(title>|description>)' | \
  sed -n '4,$p' | \
  sed -e 's/<title>//' -e 's/<\/title>//' -e 's/<description>/   /' \
      -e 's/<\/description>//' | \
  sed -e 's/<!\[CDATA\[//g' |            
  sed -e 's/\]\]>//g' |         
  sed -e 's/<[^>]*>//g' |      
  head $headarg | sed G | fmt
