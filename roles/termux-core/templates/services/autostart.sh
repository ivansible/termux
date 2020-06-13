#!{{ termux_bash }}
echo "$(date) :: $(df -h {{ root_dir }} |tail -1)" | tee -a {{ boot_log }}
. $PREFIX/etc/profile
{{ wakelock_comment }}termux-wake-lock
{{ ubuntu_ssh_comment }}{{ ubuntu_start }} "/etc/init.d/ssh start" & >/dev/null 2>&1
