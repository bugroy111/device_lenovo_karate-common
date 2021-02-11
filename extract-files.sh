#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

ONLY_COMMON=
ONLY_TARGET=
KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-common )
                ONLY_COMMON=true
                ;;
        --only-target )
                ONLY_TARGET=true
                ;;
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

#
# Hax libaudcal.so to store acdbdata in new path
#
function blob_fixup() {
    case "${1}" in
    system_ext/etc/init/dpmd.rc)
        sed -i "s/\/system\/product\/bin\//\/system\/system_ext\/bin\//g" "${2}"
        ;;
    system_ext/etc/permissions/com.qti.dpmframework.xml)
        ;&
    system_ext/etc/permissions/dpmapi.xml)
        sed -i "s/\/system\/product\/framework\//\/system\/system_ext\/framework\//g" "${2}"
        ;;
    system_ext/etc/permissions/qcrilhook.xml)
        ;&
    system_ext/etc/permissions/telephonyservice.xml)
        sed -i "s/\/system\/framework\//\/system\/system_ext\/framework\//g" "${2}"
        ;;
    system_ext/etc/permissions/qti_libpermissions.xml)
        sed -i "s/name=\"android.hidl.manager-V1.0-java/name=\"android.hidl.manager@1.0-java/g" "${2}"
        ;;
    product/lib64/libdpmframework.so)
        for LIBDPM_SHIM in $(grep -L "libshim_dpmframework.so" "${2}"); do
            "${PATCHELF}" --add-needed "libshim_dpmframework.so" "$LIBDPM_SHIM"
        done
        ;;
    product/lib64/lib-imsvideocodec.so)
        for LIBUI_SHIM in $(grep -L "libui_shim.so" "${2}"); do
            "${PATCHELF}" --add-needed "libui_shim.so" "$LIBUI_SHIM"
        done
        ;;
    vendor/bin/mm-qcamera-daemon)
        for LIBSHIMS_ANDROID in $(grep -L "libshims_android.so" "${2}"); do
	    "${PATCHELF}" --add-needed "libshims_android.so" "$LIBSHIMS_ANDROID"
        done
        ;;
    vendor/lib/libaudcal.so)
        sed -i "s|\/data\/vendor\/misc\/audio\/acdbdata\/delta\/|\/data\/vendor\/audio\/acdbdata\/delta\/\x00\x00\x00\x00\x00|g" "${2}"
        ;;
    vendor/lib64/libaudcal.so)
        sed -i "s|\/data\/vendor\/misc\/audio\/acdbdata\/delta\/|\/data\/vendor\/audio\/acdbdata\/delta\/\x00\x00\x00\x00\x00|g" "${2}"
        ;;
    vendor/lib/libmmcamera2_stats_modules.so | vendor/lib/libmmsw_platform.so | vendor/lib/libmmsw_detail_enhancement.so)
         sed -i "s|libandroid.so|libcamshim.so|g" "${2}"
         sed -i "s|libgui.so|libfui.so|g" "${2}"
        ;;
    vendor/lib64/libsettings.so)
        "${PATCHELF}" --replace-needed "libprotobuf-cpp-full.so" "libprotobuf-cpp-full-v28.so" "${2}"
        ;;
    vendor/lib64/libwvhidl.so)
        "${PATCHELF}" --replace-needed "libprotobuf-cpp-lite.so" "libprotobuf-cpp-lite-v28.so" "${2}"
        ;;
    esac
}

# Initialize the helper for common device
if [ -z "${ONLY_TARGET}" ]; then
    # Initialize the helper for common device
    setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

if [ -z "${ONLY_COMMON}" ] && [ -s "${MY_DIR}/../${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    source "${MY_DIR}/../${DEVICE}/extract-files.sh"
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

    extract "${MY_DIR}/../${DEVICE}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

"${MY_DIR}/setup-makefiles.sh"
