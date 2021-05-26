#!/bin/sh

awk '/^Mem/ {print $3}' <(free -m)
