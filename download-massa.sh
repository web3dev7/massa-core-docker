#!/bin/bash

MASSA_PACKAGE="massa_${VERSION}_release_linux.tar.gz"
MASSA_PACKAGE_ARM64="massa_${VERSION}_release_linux_arm64.tar.gz"
MASSA_PACKAGE_LOCATION="https://github.com/massalabs/massa/releases/download/$VERSION/"

package=""

if [ -n "$ARM" ]; then
	package=$MASSA_PACKAGE_ARM64
else
	package=$MASSA_PACKAGE
fi

# Download the package
curl -Ls -o "$package" "$MASSA_PACKAGE_LOCATION/$package"

# Extract the package's content
tar -zxpf "$package"
mv /massa /massa-"$VERSION"
ln -s /massa-"$VERSION" /massa

# Delete the package
rm "$package"
