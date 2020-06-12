#!/system/bin/sh
set -x

disk_img="{{ termux_vdisk_image }}"
bind_dir="{{ termux_bind_dir }}"
disk_fs={{ termux_vdisk_fstype }}
bind_ctx={{ termux_selinux_context }}

echo "check termux: $(date)"
if [ -e "$disk_img" ]; then
    # unmount filesystem before force-check
    umount -l "$bind_dir" && sleep 1 || true
    /system/bin/e2fsck -fy "$disk_img"

    while [ -z "$lodev" ]; do
        lodev=$(/system/bin/losetup -fs "$disk_img")
        echo $lodev
        sleep 1
    done

    mount -t "$disk_fs" -o rw,noatime,context=${bind_ctx} "$lodev" "$bind_dir"
    echo "mount termux: $(date)"
fi
