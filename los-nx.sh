#!/bin/bash

# fix eror
rm -rf prebuilts/clang/host/linux-x86

# repo init rom
repo init -u https://github.com/los-nx/android.git -b lineage-22.2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# sync
/opt/crave/resync.sh || repo sync
echo "============="
echo "Sync success"
echo "============="

# Cloning Trees

git clone https://github.com/AbuRider/android_device_xiaomi_earth.git -b lineage-22.2 device/xiaomi/earth

git clone https://github.com/mt6768-dev/proprietary_vendor_xiaomi_earth.git -b lineage-22.2 vendor/xiaomi/earth

git clone https://github.com/LineageOS/android_kernel_xiaomi_earth.git -b lineage-22.2 kernel/xiaomi/earth

git clone https://github.com/LineageOS/android_hardware_xiaomi.git -b lineage-22.2 hardware/xiaomi

git clone https://github.com/LineageOS/android_hardware_mediatek.git -b lineage-22.2 hardware/mediatek

git clone https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr.git -b lineage-22.2 device/mediatek/sepolicy_vndr

git clone https://github.com/AbuRider/signing_keys.git -b main vendor/lineage-priv/keys

# Remove New QS A15 Qpr2
rm -rf vendor/lineage
git clone --depth=1 vendor/lineage

# Export
export BUILD_USERNAME=aisy
export BUILD_HOSTNAME=umbrella
export TZ=Asia/Jakarta

# initiate build setup
. build/envsetup.sh
lunch lineage_earth-bp1a-userdebug
make bacon -j$(nproc --all)
