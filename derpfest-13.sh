#!/bin/bash

# fix eror
rm -rf prebuilts/clang/host/linux-x86
rm -rf prebuilts/rust

# repo init rom
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 13 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# sync
/opt/crave/resync.sh || repo sync
echo "==========================="
echo " sync repository success..."
echo "==========================="

# dontol kucai
rm -rf device/xiaomi/earth
rm -rf kernel/xiaomi/earth
rm -rf vendor/xiaomi/earth
rm -rf hardware/mediatek
rm -rf hardware/xiaomi
rm -rf device/mediatek/sepolicy_vndr
rm -rf vendor/lineage-priv/keys

git clone https://github.com/AbuRider/android_device_xiaomi_earth.git -b Derpfest-13 device/xiaomi/earth

git clone https://github.com/AbuRider/proprietary_vendor_xiaomi_earth.git -b lineage-20 vendor/xiaomi/earth

git clone https://github.com/LineageOS/android_kernel_xiaomi_earth.git -b lineage-22.2 kernel/xiaomi/earth

git clone https://github.com/AbuRider/android_hardware_xiaomi.git -b lineage-20 hardware/xiaomi

git clone https://github.com/LineageOS/android_hardware_mediatek.git -b lineage-20 hardware/mediatek

git clone https://github.com/AbuRider/android_device_mediatek_sepolicy_vndr.git -b lineage-20 device/mediatek/sepolicy_vndr

git clone https://github.com/AbuRider/sign_keys_priv.git -b main vendor/lineage-priv/keys

# Export
export BUILD_USERNAME=yusup
export BUILD_HOSTNAME=priatampan
export TZ=Asia/Jakarta
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true

# initiate build setup
. build/envsetup.sh
lunch derp_earth-userdebug
make installclean
mka derp -j$(nproc --all)
