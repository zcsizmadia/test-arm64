#!/bin/bash

set -e
set -x

apt-get update -q
apt-get install -q -y --no-install-recommends wget libzstd-dev libicu-dev git ca-certificates

# Install .NET SDKs
wget --no-check-certificate https://dot.net/v1/dotnet-install.sh

bash ./dotnet-install.sh --channel "8.0" --install-dir "/usr/share/dotnet" # 8.0

export PATH=$PATH:/usr/share/dotnet

pushd src
dotnet build -c Release
dotnet run -c Release
popd
