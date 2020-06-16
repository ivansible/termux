#!{{ termux_bash }}
echo "$(date) :: $(df -h {{ root_dir }} |tail -1)" | tee -a {{ boot_log }}
. $PREFIX/etc/profile
{{ wakelock_comment }}termux-wake-lock
{# shmem requires root! #}
{{ shmem_comment }}su -c "mkdir -p /dev/shm; chmod 1777 /dev/shm"
{{ ubuntu_ssh_comment }}nohup {{ ubuntu_start }} "/etc/init.d/ssh start" >/dev/null 2>&1 &
{# workaround for non-working runsvdir #}
{{ termux_ssh_comment }}sleep 1; pgrep -f termux/files/usr/bin/sshd >/dev/null || sshd
