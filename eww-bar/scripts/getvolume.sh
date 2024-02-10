#!/bin/bash

if command -v pamixer &>/dev/null; then
    getvol='pamixer --get-volume'
    getmute() {
        pamixer --get-mute
    }
else
    getmute() {
        active=$( \
            amixer -D pulse sget Master | \
            sed -n 's/.*Left:.*\[\(on\|off\)\]$/\1/p' \
        )
        if [[ $active == 'on' ]]; then
            echo 'false'
        else
            echo 'true'
        fi
    }
    getvol='amixer -D pulse sget Master | awk -F '"'"'[^0-9]+'"'"' '"'"'/Left:/{print $3}'"'"
fi


getoutput() {
    if [ $( getmute ) = 'true' ]; then
        result=-1
    else
        result=$( eval $getvol )
    fi
    echo $result
}

getoutput


# Maybe when using listeners
# while true; do
#     new_result=$getoutput
#     if [[ $result != $new_result ]]; then
#         result=$new_result
#         echo $result > /tmp/eww_volume
#     fi
# done
