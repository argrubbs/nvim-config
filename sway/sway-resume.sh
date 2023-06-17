#!/usr/bin/env bash

sway_tty=$(ps aux | grep '[0-9] sway$' | tr ' ' '\n' | grep tty | head -n 1 | xargs | sed 's/tty//g') 

other_tty=$(ps aux  | grep -v tty$sway_tty | grep '^root.* tty' | tr ' ' '\n' | grep ^tty | sort | uniq | head -n 1 | xargs | sed 's/tty//g')


swaymsg "output * dpms on"

if [ ! -z "$sway_tty" ]; then
	if [ -z "$other_tty" ]; then
		other_tty=$(($sway_tty+1))
	fi

	#echo $other_tty
	#echo $sway_tty
	
	sudo chvt $other_tty && sleep 2
	sudo chvt $sway_tty
fi

swaymsg "output * dpms on"
swaymsg "reload"

