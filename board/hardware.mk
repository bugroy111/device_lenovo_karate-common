# CMHW
BOARD_USES_CYANOGEN_HARDWARE := true
BOARD_HARDWARE_CLASS += \
    hardware/cyanogen/cmhw

# Tap-to-Wake
TARGET_TAP_TO_WAKE_NODE := "/sys/class/input/input1/device/wake_gesture"
