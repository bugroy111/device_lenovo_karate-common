#! /vendor/bin/sh
# Copyright (c) 2012, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#      from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
serialno=`getprop persist.usb.serialno`
case "$serialno" in
	"")
	bootmode=`getprop ro.boot.mode`
	case "$bootmode" in
		"ffbm-01")
		echo "0123456789" > /sys/class/android_usb/android0/iSerial
		;;
		*)
		serialnum=`getprop ro.serialno`
		if [ -n "$serialnum" ]; then
			echo "$serialnum" > /sys/class/android_usb/android0/iSerial
		else
			echo "$serialno" > /sys/class/android_usb/android0/iSerial
		fi
	esac
	;;
	*);;
esac

chown -h root.system /sys/devices/platform/msm_hsusb/gadget/wakeup
chmod -h 220 /sys/devices/platform/msm_hsusb/gadget/wakeup

iproduct=`getprop ro.build.product`
if [ -n "$iproduct" ]; then
	echo "$iproduct" > /sys/class/android_usb/android0/iProduct
else
	echo "Karate" > /sys/class/android_usb/android0/iProduct
fi

#
# Initialize RNDIS Diag option. If unset, set it to 'none'.
#
diag_extra=`getprop persist.sys.usb.config.extra`
if [ "$diag_extra" == "" ]; then
	setprop persist.sys.usb.config.extra none
fi

# soc_ids for 8937
if [ -f /sys/devices/soc0/soc_id ]; then
	soc_id=`cat /sys/devices/soc0/soc_id`
else
	soc_id=`cat /sys/devices/system/soc/soc0/id`
fi

# enable rps cpus on msm8937 target
setprop sys.usb.rps_mask 0
case "$soc_id" in
	"294" | "295")
		setprop sys.usb.rps_mask 40
	;;
esac
