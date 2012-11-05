#!/bin/bash

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

