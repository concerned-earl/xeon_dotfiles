#!/bin/bash

awk '/^Mem/ {print $3}' <(free -m)
