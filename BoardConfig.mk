#
# Copyright (C) 2019 Potato Open Sauce Project
# Copyright (C) 2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/xiaomi/chopin
CHOPIN_PREBUILT := device/xiaomi/chopin-prebuilts

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor

# Assertation
TARGET_OTA_ASSERT_DEVICE := chopin,choping

# Android Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 3
BOARD_AVB_VBMETA_SYSTEM := product system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_AVB_VBMETA_VENDOR := vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 4

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth/include

# Build system
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := chopin
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 440

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/config.fs

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):libinit_chopin
TARGET_RECOVERY_DEVICE_MODULES := libinit_chopin

# Kernel
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=bootloader

# Kernel Offset
BOARD_KERNEL_PAGESIZE := 2048
BOARD_DTB_OFFSET := 0x07c08000
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_TAGS_OFFSET := 0x07c08000
BOARD_KERNEL_SECOND_OFFSET := 0xbff88000
BOARD_RAMDISK_OFFSET := 0x11088000

# Kernel prebuilt option
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(IS_GLOBAL),true)
TARGET_PREBUILT_KERNEL := $(CHOPIN_PREBUILT)/base/Global/Image.gz
TARGET_PREBUILT_DTB := $(CHOPIN_PREBUILT)/base/Global/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(CHOPIN_PREBUILT)/base/Global/dtbo.img
else
TARGET_PREBUILT_KERNEL := $(CHOPIN_PREBUILT)/base/China/Image.gz
TARGET_PREBUILT_DTB := $(CHOPIN_PREBUILT)/base/China/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(CHOPIN_PREBUILT)/base/China/dtbo.img
endif

BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_APPEND_DTB := false
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

# Kernel source option
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_SOURCE := kernel/xiaomi/chopin
TARGET_KERNEL_CONFIG := chopin_user_defconfig

KERNEL_LD := LD=ld.lld
TARGET_KERNEL_ADDITIONAL_FLAGS := DTC_EXT=$(shell pwd)/prebuilts/misc/linux-x86/dtc/dtc

# Kernel mkbootimg args
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions size
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_METADATAIMAGE_PARTITION_SIZE := 33554432
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_CACHEIMAGE_PARTITION_SIZE := 136314880
BOARD_USERDATAIMAGE_PARTITION_SIZE := 115234275328
BOARD_DTBOIMG_PARTITION_SIZE := 33554432
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 1073741824
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 1073741824
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 1073741824

# Partitions Option
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_PRODUCT := product
ifeq ($(IS_GLOBAL),true)
BOARD_PREBUILT_VENDORIMAGE := $(CHOPIN_PREBUILT)/vendor/Global/vendor.img
else
BOARD_PREBUILT_VENDORIMAGE := $(CHOPIN_PREBUILT)/vendor/China/vendor.img
endif

# Partitions (Dynamic)
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
BOARD_MAIN_SIZE := 9122611200 # 9126805504/2 - 4194304
BOARD_MAIN_PARTITION_LIST := system_ext product vendor system
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := main

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_MAIN_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Platform
TARGET_BOARD_PLATFORM := mt6893

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/config/prop/product.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/config/prop/system.prop

# Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := false
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6893
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS := true

# Sepolicy
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private
TARGET_USES_PREBUILT_VENDOR_SEPOLICY := true
TARGET_HAS_FUSEBLK_SEPOLICY_ON_VENDOR := true

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)/releasetools

# Treble VNDK
BOARD_VNDK_VERSION := current

# VINTF
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/config/vintf/compatibility_matrix.device.xml
