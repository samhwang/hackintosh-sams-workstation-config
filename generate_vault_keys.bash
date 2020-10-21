#!/bin/bash

OPENCORE_VERSION=0.6.2
OPENCORE_EFI_RELEASE=OpenCore-${OPENCORE_VERSION}-RELEASE
OPENCORE_EFI_FILE=EFI/OC/OpenCore.efi
OPENCORE_EFI_PATH=../${OPENCORE_EFI_RELEASE}/X64/${OPENCORE_EFI_FILE}
PROJECT=`pwd`

echo "Removing old keys and vault";
cd EFI/OC;
rm -rf Keys OpenCore.efi vault.plist vault.sig;
cd ../..;

if [ ! -f "$OPENCORE_EFI_PATH" ]; then
  echo "OpenCore Release file doesn't exist, downloading and extracting.";
  cd ..
  curl -LkSso OpenCore-${OPENCORE_VERSION}-RELEASE.zip https://github.com/acidanthera/OpenCorePkg/releases/download/${OPENCORE_VERSION}/${OPENCORE_EFI_RELEASE}.zip;
  unzip ./${OPENCORE_EFI_RELEASE}.zip -d ${OPENCORE_EFI_RELEASE} ;
  rm ./${OPENCORE_EFI_RELEASE}.zip
  cd $PROJECT;
fi

echo "Copy OpenCore.efi\n";
cp $OPENCORE_EFI_PATH ./${OPENCORE_EFI_FILE};

echo "Generate keys"
./Utilities/CreateVault/sign.command
