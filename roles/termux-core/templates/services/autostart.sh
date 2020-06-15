#!{{ termux_bash }}
echo "$(date) :: $(df -h {{ root_dir }} |tail -1)" | tee -a {{ boot_log }}
. $PREFIX/etc/profile
{{ wakelock_comment }}termux-wake-lock
{{ ubuntu_ssh_comment }}nohup {{ ubuntu_start }} "/etc/init.d/ssh start" >/dev/null 2>&1 &
{# workaround for runsvdir not working #}
{{ termux_ssh_comment }}sleep 1; pgrep -f termux/files/usr/bin/sshd >/dev/null || sshd
