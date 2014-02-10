#!/bin/sh

for file in 0*.mp3 ; 
do 
  echo "mv \"$file\" \"`echo $file | sed 's/0. - //'`\"" ; 
done
