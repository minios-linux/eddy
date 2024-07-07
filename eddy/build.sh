#!/bin/bash

# Define variables
REPO=https://github.com/donadigo/eddy
NAME=eddy
VERSION=1.3.2

# Convert NAME to lower case
PACKAGE_NAME=$(echo "$NAME" | tr '[:upper:]' '[:lower:]')

# Remove 'v' or 'V' if it is the first character
if [[ $VERSION == [vV]* ]]; then
    PACKAGE_VERSION="${VERSION:1}"
else
    PACKAGE_VERSION="$VERSION"
fi

# Clone Upstream using NAME
git clone $REPO -b $VERSION
mv ./eddy ./$PACKAGE_NAME-$PACKAGE_VERSION
cp -rvf ./debian ./$PACKAGE_NAME-$PACKAGE_VERSION
cd ./$PACKAGE_NAME-$PACKAGE_VERSION

# Create orig archive
tar czvf ../${PACKAGE_NAME}_${PACKAGE_VERSION}.orig.tar.gz .

# Get build dependencies
apt-get build-dep . -y

# Build package
dpkg-buildpackage -uc -us
