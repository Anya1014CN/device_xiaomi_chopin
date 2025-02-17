# Copyright (C) 2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_INIT_RC := vendor.lineage.livedisplay@2.0-service-mediatek.rc
LOCAL_MODULE := vendor.lineage.livedisplay@2.0-service-mediatek
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_PROPRIETARY_MODULE := true
LOCAL_SHARED_LIBRARIES := \
	libbase \
	libbinder \
	libcutils \
	libhidlbase \
	libhidltransport \
	libutils \
	vendor.lineage.livedisplay@2.0

LOCAL_SRC_FILES := \
	DisplayColorCalibration.cpp \
	service.cpp

include $(BUILD_EXECUTABLE)