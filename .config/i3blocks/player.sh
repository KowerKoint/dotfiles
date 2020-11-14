#!/bin/bash

DEFAULT_WS="6:y"

filename=$(playerctl metadata xesam:url)
ext="${filename##*.}"
case "$ext" in
	avi|mp4|mkv)
		t=v
		;;
	mp3|wav)
		t=a
		;;
	*)
		t=a
esac

player=$(playerctl -l | head -1 | tr '[:upper:]' '[:lower:]' | tr -dc '[:alnum:]')

playerws=$(i3-msg -t get_tree | jq -r 'recurse(.nodes[]) | select(.type? == "workspace") | select(recurse(.nodes[]) | select(.window_properties.class == "'$player'")) | .name')

[ -z "$playerws" ] && playerws="$DEFAULT_WS"
playersws=$(echo "$playerws" | cut -d ':' -f 2)

focused=$(i3-msg -t get_workspaces | jq -r 'map(select( .focused == true))[0].name')

hs=$(pactl list | grep 'Name: bluez_card.' | tail -1 | awk '{print $NF}')

case "$1" in
	play)
		[ -n "$hs" ] && { pactl set-card-profile $hs a2dp_sink || { notify-send "headset error: please restart headset" && exit 1; }; }
		[ "$t" == "v" ] && xdotool key super+$playersws
		playerctl play
		;;
	pause)
		[ -n "$hs" ] && pactl set-card-profile $hs off
		if [ "$t" == "v" -a "$focused" == "$playerws" ]; then
			xdotool key super+6
		fi
		playerctl pause
		;;
	stop)
		[ -n "$hs" ] && pactl set-card-profile $hs off
		if [ "$t" == "v" -a "$focused" == "$playerws" ]; then
			xdotool key super+6
		fi
		playerctl stop
		;;
	next)
		[ "$t" == "a" ] && playerctl next
		[ "$t" == "v" ] && playerctl position 10+
		;;
	prev)
		[ "$t" == "a" ] && playerctl previous
		[ "$t" == "v" ] && playerctl position 5-
		;;
	forward)
		[ "$t" == "v" ] && playerctl next
		[ "$t" == "a" ] && playerctl position 10+
		;;
	rewind)
		[ "$t" == "v" ] && playerctl previous
		[ "$t" == "a" ] && playerctl position 5-
		;;
	*)
		echo "invalid arg"
		exit 1
esac
