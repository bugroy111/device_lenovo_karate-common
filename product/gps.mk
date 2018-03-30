# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml

# GNSS Impl HAL
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl
