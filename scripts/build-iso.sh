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

sysresccdISORoot=/build/sysresccd/customcd/isoroot
sysresccdRoot=/build/sysresccd
stage4TarPath="/build/foss-cloud-stage4.tar"
stage4TarBzPath="${sysresccdISORoot}/stages/foss-cloud-stage4.tar.bz2"
installerPath="/build/installer"

read -p "FOSS-Cloud version: " fosscloudVersion

echo "Compressing stage4 tarball..."
bzip2 -p -c "${stage4TarPath}" > "${stage4TarBzPath}"

echo "Copying installer files from ${installerPath}..."
cp -ar "${installerPath}"/* "${sysresccdRoot}/customcd/isoroot/"

echo "Regenerating the sysresscd environment..."
"${sysresccdRoot}/scripts/gen_squashfs.sh"

echo "Generate the ISO file..."
"${sysresccdRoot}/scripts/gen_iso.sh" $fosscloudVersion

ls -la "${sysresccdRoot}/isofile/"

