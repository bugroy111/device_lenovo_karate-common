#! /vendor/bin/sh
# Copyright (c) 2009-2017, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

chown -h system:system /sys/devices/soc/qpnp-smbcharger-*/battery_max_current

echo 1 > /proc/sys/net/ipv6/conf/default/accept_ra_defrtr

#
# Make modem config folder and copy firmware config to that folder for RIL
#
if [ -f /data/vendor/radio/ver_info.txt ]; then
    prev_version_info=`cat /data/vendor/radio/ver_info.txt`
else
    prev_version_info=""
fi

cur_version_info=`cat /firmware/verinfo/ver_info.txt
if [ ! -f /firmware/verinfo/ver_info.txt -o "$prev_version_info" != "$cur_version_info" ]; then
    # add W for group recursively before delete
    chmod g+w -R /data/vendor/modem_config/*
    chmod g+w -R /data/vendor/modem_config/mcfg_sw
    rm -rf /data/vendor/radio/modem_config
    # preserve the read only mode for all subdir and files
    cp --preserve=m -dr /firmware/image/modem_pr/mcfg/configs/* /data/vendor/radio/modem_config
    # the group must be root, otherwise this script could not add "W" for group recursively
    chown -hR radio.root /data/vendor/radio/modem_config
    chown -hR radio.root /data/vendor/radio/modem_config/mcfg_sw

    cp --preserve=m -d /firmware/image/3uk.mbn /data/vendor/radio/modem_config/mcfg_sw/3uk.mbn
    cp --preserve=m -d /firmware/image/gcf.mbn /data/vendor/radio/modem_config/mcfg_sw/gcf.mbn
    cp --preserve=m -d /firmware/image/mexico.mbn /data/vendor/radio/modem_config/mcfg_sw/mexico.mbn
    cp --preserve=m -d /firmware/image/ntel.mbn /data/vendor/radio/modem_config/mcfg_sw/ntel.mbn
    cp --preserve=m -d /firmware/image/rjil.mbn /data/vendor/radio/modem_config/mcfg_sw/rjil.mbn
    cp --preserve=m -d /firmware/image/row.mbn /data/vendor/radio/modem_config/mcfg_sw/row.mbn
    cp --preserve=m -d /firmware/image/smtf.mbn /data/vendor/radio/modem_config/mcfg_sw/smtf.mbn
    cp --preserve=m -d /firmware/image/ytl.mbn /data/vendor/radio/modem_config/mcfg_sw/ytl.mbn

    cp --preserve=m -d /firmware/verinfo/ver_info.txt /data/vendor/radio/ver_info.txt
    chown radio.radio /data/vendor/radio/ver_info.txt
fi
chmod g-w /data/vendor/modem_config
chmod g-w /data/vendor/modem_config/mcfg_sw
setprop ro.runtime.mbn_copy_completed 1
