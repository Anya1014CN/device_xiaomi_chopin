#
# Copyright (C) 2020 Android Open Source Project
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

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Call proprietary blob setup
$(call inherit-product-if-exists, vendor/xiaomi/chopin/chopin-vendor.mk)

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

#Suppot to compile recovery without msm headers
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

# VNDK
PRODUCT_SHIPPING_API_LEVEL := 30
PRODUCT_TARGET_VNDK_VERSION := 31
PRODUCT_EXTRA_VNDK_VERSIONS := 31
PRODUCT_COPY_FILES += \
    prebuilts/vndk/v30/arm64/arch-arm64-armv8-a/shared/vndk-core/libmedia_helper.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmedia_helper-v30.so \
    prebuilts/vndk/v30/arm64/arch-arm64-armv8-a/shared/vndk-sp/libunwindstack.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libunwindstack-v30.so \
    prebuilts/vndk/v30/arm64/arch-arm64-armv8-a/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libutils-v30.so \
    prebuilts/vndk/v30/arm64/arch-arm-armv8-a/shared/vndk-core/libmedia_helper.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmedia_helper-v30.so \
    prebuilts/vndk/v30/arm64/arch-arm-armv8-a/shared/vndk-sp/libunwindstack.so:$(TARGET_COPY_OUT_VENDOR)/lib/libunwindstack-v30.so \
    prebuilts/vndk/v30/arm64/arch-arm-armv8-a/shared/vndk-sp/libutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libutils-v30.so

# Libshims
PRODUCT_PACKAGES += \
    libshim_vtservice \
    libshim_showlogo

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Audio
PRODUCT_COPY_FILES += \
    android.hardware.audio@6.0-impl \
    android.hardware.bluetooth.audio@2.0-impl \
    android.hardware.audio.effect@6.0-impl \
    audio.a2dp.default \
    audio_policy.stub \
    audio.r_submix.default \
    audio.usb.default
    audio.bluetooth.default \
    audio.usb.default \
    libalsautils \
    libaudiofoundation.vendor \
    libbluetooth_audio_session \
    libtinycompress \
    libaudio-resampler \
    libaudiopolicyengineconfigurable
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/a2dp_in_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/bluetooth_audio_policy_configuration.xml

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-mtkimpl.recovery \
    android.hardware.boot@1.1-mtkimpl

PRODUCT_PACKAGES_DEBUG += \
    bootctrl

# Build MT-PL-Utils
PRODUCT_PACKAGES += \
    mtk_plpath_utils \
    mtk_plpath_utils.recovery

# GCamGo Prebuilts
PRODUCT_PACKAGES += \
    GCamGoPrebuilts

# DT2W
PRODUCT_PACKAGES += \
    DT2W-Service-MT6891

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# Fstab in ramdisk
PRODUCT_PACKAGES += \
    fstab.mt6893 \
    fstab.emmc \
    fstab.ramdisk

# F2FS
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0 \
    android.hidl.memory.block@1.0.vendor \
    android.hidl.memory.block@1.0 \
    libhwbinder \
    libhwbinder.vendor \
    libhidltransport.vendor \
    libhidltransport

# IMS
PRODUCT_BOOT_JARS += \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-base \
    mediatek-ims-common \
    mediatek-telecom-common \
    mediatek-telephony-base \
    mediatek-telephony-common

PRODUCT_PACKAGES += \
    ImsServiceBase \
    libshim_vtservice

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml \
    $(LOCAL_PATH)/config/permissions/systemext-privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/systemext-privapp-permissions-mediatek.xml

# Copy the kernel dtb from the prebuilts directory.
ifeq ($(IS_GLOBAL),true)
PRODUCT_COPY_FILES += \
    $(CHOPIN_PREBUILT)/base/Global/dtb.img:dtb.img
else
PRODUCT_COPY_FILES += \
    $(CHOPIN_PREBUILT)/base/China/dtb.img:dtb.img
endif

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/keylayout/uinput-fpc.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-fpc.kl \
    $(LOCAL_PATH)/config/keylayout/uinput-goodix.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/uinput-goodix.kl \
    $(LOCAL_PATH)/config/keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/idc/uinput-fpc.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/uinput-fpc.idc \
    $(LOCAL_PATH)/config/idc/uinput-goodix.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/uinput-goodix.idc

# Lights
PRODUCT_PACKAGES += \
    android.hardware.lights-service.xiaomi_mt6893

# LiveDisplay
PRODUCT_PACKAGES += \
    vendor.lineage.livedisplay@2.0-service-mediatek

# Location
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/gps/gps_debug.conf:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/gps_debug.conf

# MIUI Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/permissions/privapp-permissions-miuicamera.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-miuicamera.xml \
    $(LOCAL_PATH)/config/sysconfig/hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/hiddenapi-package-whitelist.xml

# MtkInCallService
PRODUCT_PACKAGES += \
    MtkInCallService

# NFC
PRODUCT_PACKAGES += \
    NfcNci \
    com.android.nfc_extras \
    Tag \
    SecureElement

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_PACKAGES += \
    FrameworkResOverlayChopin \
    WifiResOverlayChopin \
    SystemUIOverlayChopin \
    TelephonyOverlayChopin

# Power Perf
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/power/powerscntbl.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/powerscntbl.xml

# Rootdir
PRODUCT_PACKAGES += \
    init.recovery.mt6891.rc \
    init.recovery.mt6893.rc \
    init.recovery.usb.rc \
    init.mt6893.rc \
    init.mt6891.rc

PRODUCT_COPY_FILES +=  $(DEVICE_PATH)/rootdir/etc/fstab.mt6893:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/30/etc/fstab.mt6893

# Screen density
PRODUCT_AAPT_CONFIG := xxxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Xiaomi Parts
PRODUCT_PACKAGES += \
    XiaomiParts

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Properties
include $(LOCAL_PATH)/config/prop/default.mk

# Update engine
PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0-impl \
    android.hardware.thermal@2.0.vendor

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.1.vendor \
    android.hardware.usb.gadget@1.1.vendor

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator-V1-ndk_platform.vendor

# Wi-Fi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service-lazy \
    android.hardware.wifi.supplicant@1.3.vendor \
    android.hardware.wifi.hostapd@1.2.vendor \
    libkeystore-engine-wifi-hidl:64 \
    libkeystore-wifi-hidl

# Tethering
PRODUCT_PACKAGES += \
    android.hardware.tetheroffload.config@1.0.vendor \
    android.hardware.tetheroffload.control@1.0.vendor \
    TetheringConfigOverlayChopin \
    WifiOverlayAres

# Secure element
PRODUCT_PACKAGES += \
    android.hardware.secure_element@1.2.vendor

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.0-ScopedWakelock.vendor \
    android.hardware.sensors@2.0.vendor \
    libsensorndkbridge

# IR
PRODUCT_PACKAGES += \
    android.hardware.ir@1.0-service \
    android.hardware.ir@1.0-impl \
    android.hardware.ir@1.0.vendor \
    android.hardware.ir@1.0

# Soundtrigger
PRODUCT_PACKAGES += \
    android.hardware.soundtrigger@2.3-impl

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service

# Neutral Networks
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3.vendor

# Nfc
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2-service.st \
    android.hardware.secure_element@1.2-service.st \
    com.android.nfc_extras \
    NfcNci \
    SecureElement \
    Tag

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_ares/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_ares/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_ares/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_ares/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_ares/android.hardware.se.omapi.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_ares/android.hardware.nfc.xml

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/libese-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libese-hal-st.conf

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-V1-ndk_platform.vendor \
    android.hardware.power@1.3.vendor

# Radio
PRODUCT_PACKAGES += \
    android.hardware.radio@1.5.vendor \
    android.hardware.radio.config@1.2.vendor \
    android.hardware.radio.deprecated@1.0.vendor \
    android.hardware.radio.config@1.0 \
    android.hardware.radio@1.0 \
    android.hardware.radio@1.1 \
    android.hardware.radio@1.2 \
    android.hardware.radio@1.3 \
    android.hardware.radio@1.4

# Keymaster
PRODUCT_PACKAGES += \
    libkeymaster4.vendor:64 \
    libkeymaster4support.vendor:64 \
    libkeymaster_portable.vendor:64 \
    libkeymaster_messages.vendor:64 \
    libsoft_attestation_cert.vendor:64 \
    libpuresoftkeymasterdevice.vendor:64

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1.vendor \
    android.hardware.biometrics.fingerprint@2.2.vendor \
    android.hardware.biometrics.fingerprint@2.3.vendor

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1.vendor

# Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.2-service

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.common@1.0.vendor \
    android.hardware.camera.device@3.6.vendor \
    android.hardware.camera.provider@2.6.vendor

# CAS
PRODUCT_PACKAGES += \
    android.hardware.cas@1.2-service

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4-service.clearkey \
    android.hardware.drm@1.3.vendor \
    libmockdrmcryptoplugin \
    libdrm.vendor \
    libdrm

# RenderScript
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# Hardware trigger
PRODUCT_PACKAGES += \
    android.hardwareundtrigger@2.0 \
    android.hardwareundtrigger@2.1 \
    android.hardwareundtrigger@2.2

# Dumpstate
PRODUCT_PACKAGES += \
    android.hardware.dumpstate@1.1.vendor

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1.vendor

# TinyXML
PRODUCT_PACKAGES += \
    libtinyxml

# Text classifier
PRODUCT_PACKAGES += \
    libtextclassifier_hash.vendor \
    libtextclassifier_hash

# Vendor service
PRODUCT_PACKAGES += \
    vndservice \
    vndservicemanager

# NQ Client
PRODUCT_PACKAGES += \
    libchrome.vendor

# Additional libs
PRODUCT_PACKAGES += \
    libjsoncpp \
    liblogwrap \
    libmedialogservice \
    libpcap \
    libsparse \
    libadbconnection_server \
    libfusesideload \
    libparameter \
    libremote-processor \
    libpcap.vendor \
    libstagefright_softomx.vendor