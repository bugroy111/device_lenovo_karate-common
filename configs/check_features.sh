#!/sbin/sh

lenovo_id="/sys/devices/soc0/platform_lenovo_hardware_type"

if [ "$lenovo_id" = "S82937EA1" ] || [ "$lenovo_id" = "S82937CA1" ]; then
    rm -rf /system/app/QtiTelephonyService
    rm /system/framework/QtiTelephonyServicelibrary.jar
    rm /system/framework/qti-telephony-common.jar
fi
