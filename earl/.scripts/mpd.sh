#!/bin/sh

case "$(pidof mpd | wc -w)" in

0)  mpd &
    ;;
1)  # all ok
    ;;
*)  kill $(pidof mpd) 
    ;;
esac

