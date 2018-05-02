#
# Copyright (C) 2017 The LineageOS Project
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

LOCAL_PATH := device/lenovo/karate-common

WITH_LINEAGE_CHARGER := false

# Inherit device-specific board fragments
include $(LOCAL_PATH)/board/*.mk

# Inherit the proprietary files
-include vendor/lenovo/karate-common/BoardConfigVendor.mk

# Manifest
DEVICE_MANIFEST_FILE := $(LOCAL_PATH)/configs/manifest.xml
DEVICE_MATRIX_FILE   := $(LOCAL_PATH)/configs/compatibility_matrix.xml

# Properties
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_VENDOR_PROP += device/lenovo/karate-common/vendor.prop

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_SHIPPING_API_LEVEL := 24
PRODUCT_COMPATIBILITY_MATRIX_LEVEL_OVERRIDE := 27
