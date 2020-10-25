#!/bin/bash

export LC_TIME="en_US.UTF-8"
TIME=$(date +"%H:%M")
DATE=$(date +"%a %d/%m")

BATTERY_PERCENTAGE=$(pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto | cut -f1 -d'%')
BATTERY_STATUS=$(pmset -g batt | grep "'.*'" | sed "s/'//g" | cut -c 18-19)
BATTERY_REMAINING=$(pmset -g batt | egrep -o '([0-9]+%).*' | cut -d\  -f3)

BATTERY_CHARGING=""
if [ "$BATTERY_STATUS" == "Ba" ]; then
  BATTERY_CHARGING="false"
elif [ "$BATTERY_STATUS" == "AC" ]; then
  BATTERY_CHARGING="true"
fi

# LOAD_AVERAGE=$(sysctl -n vm.loadavg | awk '{print $2}')
LOAD_AVERAGE=$(top -l 1 | grep ^CPU | awk '{print $3}' | cut -c -4)

WIFI_STATUS=$(ifconfig en0 | grep status | cut -c 10-)
WIFI_SSID=$(networksetup -getairportnetwork en0 | cut -c 24-)

DND=$(defaults -currentHost read com.apple.notificationcenterui doNotDisturb)

# AIRPODS INFO
BT_DEFAULTS=$(defaults read /Library/Preferences/com.apple.Bluetooth)
SYS_PROFILE=$(system_profiler SPBluetoothDataType 2>/dev/null)
NAME=$(grep -a4 "Minor Type: Headphones"<<<"${SYS_PROFILE}" | grep -i -B7 "Connected: Yes" | head -1 | awk '{$1=$1};1' )
MAC_ADDR=$(grep -a4 "Minor Type: Headphones"<<<"${SYS_PROFILE}" | grep -i -B7 "Connected: Yes" | awk '/Address:/{print $2}'     )
BT_DATA=$(grep -ia6 '"'"${MAC_ADDR}"'"'<<<"${BT_DEFAULTS}")
CONNECTED=$(grep -ia6 "${MAC_ADDR}"<<<"${SYS_PROFILE}"|awk '/Connected: Yes/{print 1}')
LEFT=$(awk -v pat="BatteryPercentLeft" '$0~pat{gsub (";",""); print $3 }'<<<"${BT_DATA}")
RIGHT=$(awk -v pat="BatteryPercentRight" '$0~pat{gsub (";",""); print $3 }'<<<"${BT_DATA}")
# CONNECTED=$(1)
echo $(cat <<-EOF
{
    "datetime": {
        "time": "$TIME",
        "date": "$DATE"
    },
    "battery": {
        "percentage": $BATTERY_PERCENTAGE,
        "charging": $BATTERY_CHARGING,
        "remaining": "$BATTERY_REMAINING"
    },
    "cpu": {
        "loadAverage": $LOAD_AVERAGE
    },
    "wifi": {
        "status": "$WIFI_STATUS",
        "ssid": "$WIFI_SSID"
    },
    "dnd": $DND,
	"airpods": {
		"connected": "$CONNECTED",
		"left": "$LEFT",
		"right": "$RIGHT",
		"name": "$NAME"
	}
}
EOF
)
