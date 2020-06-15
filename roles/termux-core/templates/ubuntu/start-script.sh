#!{{ termux_bash }}
cd $(dirname $0)
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r {{ ubuntu_fs }}"
command+=" -b /dev"
command+=" -b /proc"
command+=" -b {{ termux_root_dir }}/home:/root"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH={{ termux_ubuntu_path }}"
command+=" LANG={{ termux_ubuntu_locale }}"
command+=" TERM=$TERM"
command+=" /bin/bash --login"
[ -n "$1" ] && $command -c "$@" || exec $command
