#!/bin/bash

cd $GITHUB_WORKSPACE/$VENDOR-imagebuilder-$VERSION-armsr-armv8.Linux-x86_64 || exit

# Remove redundant default packages
sed -i "/luci-app-cpufreq/d" include/target.mk

# Force opkg to overwrite files
sed -i "s/install \$(BUILD_PACKAGES)/install \$(BUILD_PACKAGES) --force-overwrite/" Makefile

# Not generate ISO images for it is too big
sed -i "s/CONFIG_ISO_IMAGES=y/# CONFIG_ISO_IMAGES is not set/" .config

# Not generate VHDX images
sed -i "s/CONFIG_VHDX_IMAGES=y/# CONFIG_VHDX_IMAGES is not set/" .config

# Increase rootfs partition size to 1024M
sed -i "s/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=1024/" .config
