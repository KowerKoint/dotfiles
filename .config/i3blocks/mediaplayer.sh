#!/usr/bin/env bash

title=`playerctl metadata xesam:title`
artist=`playerctl metadata xesam:artist`
url=`playerctl metadata xesam:url | nkf -w --url-input | sed -e 's/\.[^\.]*$//' | sed -e 's/^.*\///'`
if [ "$title" = "" ]; then
    echo $url
else
    echo $title
fi
