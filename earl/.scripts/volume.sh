#!/bin/sh

vol="$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))"

echo "$vol"
