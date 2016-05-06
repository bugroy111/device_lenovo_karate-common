# MIDI
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.usb.id.midi=90BA \
    ro.usb.id.midi_adb=90BB

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml
