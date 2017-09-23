# Camera
PRODUCT_PACKAGES += \
    Snap

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/camera/imx219_karateof_chromatix.xml:system/etc/camera/imx219_karateof_chromatix.xml \
    $(LOCAL_PATH)/configs/camera/imx219_karateqt_chromatix.xml:system/etc/camera/imx219_karateqt_chromatix.xml \
    $(LOCAL_PATH)/configs/camera/imx258_karateof_chromatix.xml:system/etc/camera/imx258_karateof_chromatix.xml \
    $(LOCAL_PATH)/configs/camera/imx258_karateqt_chromatix.xml:system/etc/camera/imx258_karateqt_chromatix.xml \
    $(LOCAL_PATH)/configs/camera/lenovo_karate_camera.xml:system/etc/camera/lenovo_karate_camera.xml
