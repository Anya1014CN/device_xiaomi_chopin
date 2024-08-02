#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from chopin device
$(call inherit-product, device/xiaomi/chopin/device.mk)

PRODUCT_DEVICE := chopin
PRODUCT_NAME := lineage_chopin
PRODUCT_BRAND := redmi
PRODUCT_MODEL := chopin
PRODUCT_MANUFACTURER := xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="chopin-user 11 RP1A.200720.011 V12.5.16.0.RKPCNXM release-keys"

BUILD_FINGERPRINT := redmi/chopin/chopin:11/RP1A.200720.011/V12.5.16.0.RKPCNXM:user/release-keys
