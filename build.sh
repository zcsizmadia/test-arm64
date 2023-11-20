#!/bin/bash

set -e
set -x

apt-get update -q
apt-get install -q -y --no-install-recommends curl libzstd-dev libicu-dev git ca-certificates

# Install .NET SDKs
curl --insecure https://dot.net/v1/dotnet-install.sh

bash ./dotnet-install.sh --channel "3.1" --install-dir "/usr/share/dotnet" # 3.1
bash ./dotnet-install.sh --channel "5.0" --install-dir "/usr/share/dotnet" # 5.0
bash ./dotnet-install.sh --channel "6.0" --install-dir "/usr/share/dotnet" # 6.0
bash ./dotnet-install.sh --channel "7.0" --install-dir "/usr/share/dotnet" # 7.0
bash ./dotnet-install.sh --channel "8.0" --install-dir "/usr/share/dotnet" # 8.0

export PATH=$PATH:/usr/share/dotnet

# Clone repo
git config --global url.https://github.com/.insteadOf git://github.com/
git clone https://github.com/apache/avro.git

pushd "avro/lang/csharp"
./build.sh test
popd

