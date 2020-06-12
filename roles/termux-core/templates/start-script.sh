#!{{ termux_bash }}
cd $(dirname $0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r {{ ubuntu_fs }}"
if [ -n "$(ls -A binds)" ]; then
    for script in binds/* ;do . $script ;done
fi
command+=" -b /dev"
command+=" -b /proc"
## uncomment the following line to have access to the home directory of termux
command+=" -b {{ termux_root_dir }}/home:/root"
## uncomment the following line to mount /sdcard directly to /
#command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH={{ termux_ubuntu_core_path }}"
command+=" TERM=$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
[ -n "$1" ] && $command -c "$@" || exec $command
