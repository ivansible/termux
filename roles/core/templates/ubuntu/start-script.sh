#!{{ termux_bash }}
cd $(dirname $0)
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r {{ ubuntu_fs }}"
command+=" -b /dev"
command+=" -b /proc"
{% if termux_ubuntu_extra_mounts |bool %}
# bind home directory
command+=" -b {{ termux_root_dir }}/home:/root"
command+=" -w /root"
# bind sdcards
command+=" -b /storage/emulated/0:/mnt/internal"
command+=" -b {{ termux_sdcard_abspath }}:/mnt/sdcard"
# enable running termux binaries from proot
{# /data   has termux binaries /data/data/com.termux/files/usr/bin/* #}
{# /system has termux linker   /system/bin/linker64 #}
{# /apex   has andoird shared libraries /apex/com.android.runtime/lib64/*.so #}
command+=" -b /sys"
command+=" -b /data"
command+=" -b /system"
command+=" -b /apex"
{% endif %}
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH={{ termux_ubuntu_path }}"
command+=" LANG={{ termux_ubuntu_locale }}"
command+=" TERM=$TERM"
command+=" /bin/bash --login"
[ -n "$1" ] && $command -c "$@" || exec $command
