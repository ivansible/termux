#!{{ termux_bash }}
#set -x
[ "$EUID" = 0 ] || exec sudo $0 "$@"
pref={{ termux_fixrouting_pref }}
nets="{{ termux_fixrouting_nets |join(' ') }}"
rt_tables=/data/misc/net/rt_tables
for i in {1..8}; do
    ip -6 rule del pref "$pref" >/dev/null 2>&1
done
rt_tun=$(awk '/tun0/  {print $1}' "$rt_tables" |head -1)
rt_lan=$(awk '/wlan0/ {print $1}' "$rt_tables" |head -1)
for to in $nets; do
    ip -6 rule add to "$to" pref "$pref" table "$rt_tun"
done
echo ok
