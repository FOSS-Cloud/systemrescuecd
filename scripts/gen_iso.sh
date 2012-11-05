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

WORKDIR="/build/sysresccd"

if [ ${UID} -ne 0 ] ; then
    echo "You have to be superuser"
    exit 1
fi

if [ $# -ne 1 ] ; then
    echo "Usage: $0 <VERSION>"
    exit 1
fi

ISO_VOLUME="foss-cloud-installer"
FOSS_CLOUD_VERSION="${1}"

mkdir -p "${WORKDIR}/isofile"

rm -f "${WORKDIR}/isofile/${ISO_VOLUME}-${FOSS_CLOUD_VERSION}.iso"

mkisofs -J -l \
    -o "${WORKDIR}/isofile/${ISO_VOLUME}-${FOSS_CLOUD_VERSION}.iso" \
    -b isolinux/isolinux.bin \
    -c isolinux/boot.cat \
    -input-charset utf-8 \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -V "${ISO_VOLUME}" \
    "${WORKDIR}/customcd/isoroot"

chmod a+r "${WORKDIR}/isofile/${ISO_VOLUME}-${FOSS_CLOUD_VERSION}.iso"

