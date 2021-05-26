#!/bin/sh

image=$(date +%a-%d-%b-%H-%M-%S).png && maim -m 2 -u ~/Pictures/screenshots/$image; notify-send "$image"
