include vendor/lge/lg855/BoardConfigVendor.mk

# Camera
USE_CAMERA_STUB := false

# http://r.cyanogenmod.com/#/c/13317/
COMMON_GLOBAL_CFLAGS += -DBINDER_COMPAT


# Platform
TARGET_BOARD_PLATFORM := omap3
# This is the Boost Mobile variant
TARGET_BOOTLOADER_BOARD_NAME := lg855
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
COMMON_GLOBAL_CFLAGS += -DOMAP_COMPAT

# TI-OMAP ENHANCEMENT
OMAP_ENHANCEMENT := true

ifdef OMAP_ENHANCEMENT
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP3 -DOMAP_ENHANCEMENT_CPCAM -DOMAP_ENHANCEMENT_VTC
endif

TARGET_BOOTANIMATION_PRELOAD := true

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_SPECIFIC_HEADER_PATH := device/lge/lg855/include

# Egl
BOARD_EGL_CFG := device/lge/lg855/prebuilt/lib/egl/egl.cfg
COMMON_GLOBAL_CFLAGS += -DSURFACEFLINGER_FORCE_SCREEN_RELEASE
USE_OPENGL_RENDERER := true

# ti OMX Configuration
HARDWARE_OMX := true
ifdef HARDWARE_OMX
OMX_JPEG := true
OMX_VENDOR := ti
OMX_VENDOR_INCLUDES := \
   hardware/ti/omx/system/src/openmax_il/omx_core/inc \
   hardware/ti/omx/image/src/openmax_il/jpeg_enc/inc
OMX_VENDOR_WRAPPER := TI_OMX_Wrapper
BOARD_OPENCORE_LIBRARIES := libOMX_Core
BOARD_OPENCORE_FLAGS := -DHARDWARE_OMX=1
endif

# Stagefright
TARGET_USE_OMAP_COMPAT := true
BUILD_WITH_TI_AUDIO := 1
BUILD_PV_VIDEO_ENCODERS := 1

# Touch screen compatibility for ICS
# XXX: off in FreeOptimusProject p970 config
BOARD_USE_LEGACY_TOUCHSCREEN := true

BOARD_CDMA_NETWORK := true

BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_CUSTOM_GRAPHICS := ../../../device/lge/lg855/recovery/graphics.c 

# Audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true
BUILD_WITH_ALSA_UTILS := true
BOARD_USES_TI_OMAP_MODEM_AUDIO := true
BOARD_USES_AUDIO_LEGACY := true
TARGET_PROVIDES_LIBAUDIO := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true


# Mass Storage for ICS
BOARD_CUSTOM_USB_CONTROLLER := ../../device/lge/lg855/UsbController.cpp
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/usb_mass_storage/lun%d/file

# Sensors 
BOARD_USES_GENERIC_INVENSENSE := true 

# Wireless
# XXX?
BOARD_WLAN_DEVICE		:= bcm4329
WIFI_DRIVER_FW_STA_PATH		:= "/system/etc/wifi/fw_bcm4329.bin"
WIFI_DRIVER_FW_AP_PATH		:= "/system/etc/wifi/fw_bcm4329_ap.bin"
WIFI_DRIVER_MODULE_NAME		:= "wireless"
WIFI_DRIVER_MODULE_PATH		:= "/system/lib/modules/wireless.ko"
WIFI_DRIVER_MODULE_ARG		:= "firmware_path=/system/etc/wifi/fw_bcm4329.bin nvram_path=/system/etc/wifi/nvram.txt config_path=/data/misc/wifi/config"
WPA_SUPPLICANT_VERSION		:= VER_0_6_X
WIFI_DRIVER_HAS_LGE_SOFTAP	:= true
BOARD_WEXT_NO_COMBO_SCAN	:= true
BOARD_WPA_SUPPLICANT_DRIVER	:= WEXT

# NEW Vibrator implementation, by DM47021
BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/lge/lg855/vibrator.c

# XXX: fix these
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 422576128
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2147483648

# Kernel
#TARGET_KERNEL_SOURCE := kernel/lge/hyperics
#TARGET_KERNEL_CONFIG := sniper_defconfig
TARGET_PREBUILT_KERNEL := device/lge/lg855/kernels/hicstdm/kernel
TARGET_PREBUILT_MODULES := $(wildcard device/lge/lg855/kernels/hicstdm/*.ko)
BOARD_KERNEL_CMDLINE :=
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048

# Kernel
ifneq ($(TARGET_PREBUILT_KERNEL),)
PRODUCT_COPY_FILES += \
	$(TARGET_PREBUILT_KERNEL):kernel
endif
ifneq ($(TARGET_PREBUILT_MODULES),)
PRODUCT_COPY_FILES += \
	$(foreach mod,$(TARGET_PREBUILT_MODULES),$(mod):system/lib/modules/$(notdir $(mod)))
endif


# Command line for charging mode 
BOARD_GLOBAL_CFLAGS += -DCHARGERMODE_CMDLINE_NAME='"rs"' -DCHARGERMODE_CMDLINE_VALUE='"c"'

# On LS855/LG855/VM855 PlayfulGod's recovery identifies as "marquee"
# On AS855 PlayfulGod's recovery identifies as "ignite"
TARGET_OTA_ASSERT_DEVICE := sniper,marquee,ignite,lg855,ls855
