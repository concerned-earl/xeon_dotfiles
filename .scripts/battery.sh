#!/bin/sh

# Might not work (copy-pasted)
acpi | sed "s/,//g" | awk '{if ($3 == "Discharging"){print $4; exit} else {print $4""}}' | tr -d "\n"
