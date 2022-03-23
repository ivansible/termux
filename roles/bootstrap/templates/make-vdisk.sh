#!{{ termux_bash }}
#set -x
set -e

disk_size={{ termux_vdisk_size }}
disk_fs={{ termux_vdisk_fstype }}
bind_ctx={{ termux_selinux_context }}
disk_img="{{ termux_vdisk_image }}"
bind_dir="{{ termux_bind_dir }}"
temp_dir="{{ termux_sdcard_dir }}/tmp"

mkdir -p "$(dirname "$disk_img")"
dd if=/dev/zero bs=1M status=none count=$disk_size of="$disk_img"
mkfs.${disk_fs} -q -F "$disk_img"

sudo umount -l "$bind_dir" 2>/dev/null && sleep 1 || true
while [ -z "$lodev" ]; do
    lodev=$(sudo /system/bin/losetup -fs "$disk_img" || true)
    echo $lodev
    sleep 1
done

mkdir -p "$temp_dir"
sudo mount -t "$disk_fs" -o rw,noatime,context=${bind_ctx} "$lodev" "$temp_dir"
sudo rsync -a --delete "$bind_dir/" "$temp_dir/"
{# e2fsck issues a warning if lost+found doesn't exist #}
mkdir -p "$temp_dir/lost+found"
df -h "$temp_dir"
sudo umount -l "$temp_dir"
rmdir "$temp_dir"
