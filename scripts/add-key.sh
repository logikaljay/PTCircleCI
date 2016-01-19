#!/bin/sh

KEYCHAIN_PASSWORD=circleci

security create-keychain -p $KEYCHAIN_PASSWORD ios-build.keychain
security import ./apple.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./dist.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./dist.p12 -k ~/Library/Keychains/ios-build.keychain -P $KEY_PASSWORD -T /usr/bin/codesign
security list-keychain -s ~/Library/Keychains/ios-build.keychain
security unlock-keychain -p $KEYCHAIN_PASSWORD ~/Library/Keychains/ios-build.keychain

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./profile/* ~/Library/MobileDevice/Provisioning\ Profiles/

