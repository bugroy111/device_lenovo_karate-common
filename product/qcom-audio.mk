# Audio configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/mixer_paths_karate_a42.xml:system/etc/mixer_paths_karate_a42.xml \
    $(LOCAL_PATH)/audio/mixer_paths_karate_a48.xml:system/etc/mixer_paths_karate_a48.xml \
    $(LOCAL_PATH)/audio/mixer_paths_karate_b36.xml:system/etc/mixer_paths_karate_b36.xml \
    $(LOCAL_PATH)/audio/mixer_paths_qrd_skum.xml:system/etc/mixer_paths_qrd_skum.xml \
    $(LOCAL_PATH)/audio/mixer_paths_qrd_skun.xml:system/etc/mixer_paths_qrd_skun.xml \
    $(LOCAL_PATH)/audio/mixer_paths_karate.xml:system/etc/mixer_paths_karate.xml

PRODUCT_PACKAGES += \
    audiod \
    audio.primary.msm8937 \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing
