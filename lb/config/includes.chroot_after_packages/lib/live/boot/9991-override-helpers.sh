# This overrides find_livefs to find a GPT partition labeled "live"
# Make sure plainroot is in cmdline
find_livefs() {
    TARGET_PART_NAME="live"
    for dev in /sys/class/block/*; do
        dev_name=$(basename "$dev")
        # Check if it's a partition
        if [ -e "$dev/partition" ]; then
            # Read the partition name from udev attribute
            part_name=$(cat "$dev/uevent" | grep PARTNAME | cut -d'=' -f2)
            
            # Check if the partition name matches the target name
            if [ "$part_name" == "$TARGET_PART_NAME" ]; then
                echo "/dev/$dev_name"
                PLAIN_ROOT=1
                export PLAIN_ROOT
                return 0
            fi
        fi
    done
    return 1
}
