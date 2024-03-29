#
# Copyright 2019 The Android Open Source Project
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
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

PLATFORM_PATH := device/Hisense/HLTE202N

LC_ALL=C
ALLOW_MISSING_DEPENDENCIES=true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_BOARD_PLATFORM := sdm439
TARGET_BOARD_PLATFORM_GPU := qcom-adreno505

TARGET_BOARD_SUFFIX := _64
TARGET_USES_64_BIT_BINDER := true

# Bootloader
TARGET_NO_BOOTLOADER := true 
TARGET_BOOTLOADER_BOARD_NAME := sdm439

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 6442450944
BOARD_USERDATAIMAGE_PARTITION_SIZE := 20937965568
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

# Cmdline
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 
BOARD_KERNEL_CMDLINE += androidboot.console=ttyMSM0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 
BOARD_KERNEL_CMDLINE += androidboot.bootdevice=7824900.sdhci earlycon=msm_serial_dm,0x78B0000 firmware_class.path=/vendor/firmware_mnt/image 
BOARD_KERNEL_CMDLINE += androidboot.usbconfigfs=true loop.max_part=7
#BOARD_KERNEL_CMDLINE += android.boot.selinux=permissive

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 1
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 androidboot.bootdevice=7824900.sdhci earlycon=msm_serial_dm,0x78B0000 firmware_class.path=/vendor/firmware_mnt/image androidboot.usbconfigfs=true loop.max_part=7 buildvariant=user
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_CONFIG := HLTE202N_defconfig
TARGET_KERNEL_SOURCE := kernel/hisense/HLTE202N

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(PLATFORM_PATH)/prebuilt/kernel
BOARD_PREBUILT_DTBOIMAGE := $(PLATFORM_PATH)/prebuilt/dtbo.img
BOARD_KERNEL_SEPARATED_DTBO := 
endif

# Fstab
TARGET_RECOVERY_FSTAB := $(PLATFORM_PATH)/recovery.fstab

# Init
TARGET_INIT_VENDOR_LIB := libinit_HLTE202N
TARGET_RECOVERY_DEVICE_MODULES := libinit_HLTE202N
TARGET_PLATFORM_DEVICE_BASE := /devices/soc/

# QCOM Stuff
BOARD_USES_QCOM_HARDWARE := true

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)

# Filesystem
#TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true

# Screen
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_DEFAULT_BRIGHTNESS := 50
TW_MAX_BRIGHTNESS := 100
# TW_SCREEN_BLANK_ON_BOOT := true
TW_NO_SCREEN_TIMEOUT := true
TW_NO_SCREEN_BLANK := true
# RECOVERY_GRAPHICS_FORCE_SINGLE_BUFFER := true
# RECOVERY_GRAPHICS_FORCE_USE_LINELENGTH := true

#IMX EPDC
TW_IMX_EINK := true
TW_IMX_EINK_ROTATE := 3
#TW_IMX_EINK_MONOCHROME := true

# TWRP Stuff
BOARD_HAS_LARGE_FILESYSTEM := true
TW_THEME := portrait_hdpi
TW_CUSTOM_THEME := $(if $(wildcard $(PLATFORM_PATH)/theme),$(PLATFORM_PATH)/theme)
TW_USE_TOOLBOX := true
HAVE_SELINUX := true
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_NO_LEGACY_PROPS := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TW_NO_USB_STORAGE := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true

# Show build time on the splash screen
TW_DEVICE_VERSION=$(shell date '+%Y%m%d')

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2025-12-31

# Platform version
PLATFORM_VERSION := 16.1.0

# System-as-root

#BOARD_BUILD_SYSTEM_ROOT_IMAGE := true //set is system.prop
#BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist
#BOARD_SUPPRESS_SECURE_ERASE := true
# OTA

TARGET_OTA_ASSERT_DEVICE := HLTE202N

# Treble

#BOARD_NEEDS_VENDORIMAGE_SYMLINK := false
#BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
#TARGET_COPY_OUT_VENDOR := vendor


