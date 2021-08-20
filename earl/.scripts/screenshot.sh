#!/bin/sh

image=$(date +%a-%d-%b-%H-%M-%S).png && maim -m 2 -u ~/Pictures/screenshots/fullscreen/$image; notify-send --urgency=low "$image"
