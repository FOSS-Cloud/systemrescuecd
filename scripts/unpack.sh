#!/usr/bin/env bash
#
# Copyright (C) 2012 FOSS-Group
#                    Germany
#                    http://www.foss-group.de
#                    support@foss-group.de
#
# Authors:
#  Tiziano Müller <tiziano.mueller@stepping-stone.ch>
#  
# Licensed under the EUPL, Version 1.1 or – as soon they
# will be approved by the European Commission - subsequent
# versions of the EUPL (the "Licence");
# You may not use this work except in compliance with the
# Licence.
# You may obtain a copy of the Licence at:
#
# http://www.osor.eu/eupl
#
# Unless required by applicable law or agreed to in
# writing, software distributed under the Licence is
# distributed on an "AS IS" basis,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
# express or implied.
# See the Licence for the specific language governing
# permissions and limitations under the Licence.
#
#
#

ISO_IMAGE="systemrescuecd-x86-2.0.0.iso"
WORKDIR="/build/sysresccd"

if [ ${UID} != 0 ] ; then
    echo "You have to be superuser to unpack the sysresccd"
    exit 1
fi

mkdir -p "${WORKDIR}"

bsdtar -x --include sysrcd.dat -f "${WORKDIR}/${ISO_IMAGE}" -C "${WORKDIR}"

mkdir -p "${WORKDIR}/customcd/isoroot"

bsdtar -x --include isolinux --include version -f "${WORKDIR}/${ISO_IMAGE}" -C "${WORKDIR}/customcd/isoroot"

for f in bootprog bootdisk ntpasswd usb_inst usb_inst.sh usbstick.htm ; do
    bsdtar -x --include "${f}" -f "${WORKDIR}/${ISO_IMAGE}" -C "${WORKDIR}/customcd/isoroot"
done

rm -rf "${WORKDIR}/customcd/files"
unsquashfs -dest "${WORKDIR}/customcd/files" "${WORKDIR}/sysrcd.dat"


