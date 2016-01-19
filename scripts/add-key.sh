#!/bin/sh

KEYCHAIN_PASSWORD=circleci

# base64 decode the keys
base64 --decode "$PRIVATE_KEY" > ./scripts/dist.p12
base64 --decode "$PUBLIC_KEY" > ./scripts/dist.cer

security create-keychain -p $KEYCHAIN_PASSWORD ios-build.keychain
security import ./scripts/apple.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/dist.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/dist.p12 -k ~/Library/Keychains/ios-build.keychain -P $KEY_PASSWORD -T /usr/bin/codesign
security list-keychain -s ~/Library/Keychains/ios-build.keychain
security unlock-keychain -p $KEYCHAIN_PASSWORD ~/Library/Keychains/ios-build.keychain

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./scripts/profile/* ~/Library/MobileDevice/Provisioning\ Profiles/

