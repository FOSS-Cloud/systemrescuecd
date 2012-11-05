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

runtimeRoot="/build/runtime-root"
stage4TarPath="/build/foss-cloud-stage4.tar"

read -p "FOSS-Cloud version: " fosscloudVersion

echo "${fosscloudVersion}" > "${runtimeRoot}/etc/foss-cloud_version"
chmod 644 "${runtimeRoot}/etc/foss-cloud_version"

cat > "${runtimeRoot}/etc/os-release" << EOF
NAME=FOSS-Cloud
VERSION="${fosscloudVersion}"
ID=foss-cloud
EOF
chmod 644 "${runtimeRoot}/etc/os-release"

# not yet configured
#chroot "${runtimeRoot}" localepurge

cd "${runtimeRoot}"
tar -cvpf "${stage4TarPath}" --exclude usr/local/portage/packages --exclude usr/portage --exclude .git .

