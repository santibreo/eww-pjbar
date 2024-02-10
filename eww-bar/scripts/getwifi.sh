ssid=$( nmcli --get-values 'CONNECTION' device | xargs )
if [ -z $ssid ]; then
    echo 'off'
else
    echo $ssid
fi
