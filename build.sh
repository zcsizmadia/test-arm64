#!/bin/bash

apt-get update -q
apt-get install -q -y --no-install-recommends curl libzstd-dev libicu-dev git ca-certificates

curl --insecure --output /tmp/dotnet-install.sh https://dot.net/v1/dotnet-install.sh
chmod +x /tmp/dotnet-install.sh

/tmp/dotnet-install.sh --channel "3.1" --install-dir "/usr/share/dotnet" # 3.1
/tmp/dotnet-install.sh --channel "5.0" --install-dir "/usr/share/dotnet" # 5.0
/tmp/dotnet-install.sh --channel "6.0" --install-dir "/usr/share/dotnet" # 6.0
/tmp/dotnet-install.sh --channel "7.0" --install-dir "/usr/share/dotnet" # 7.0
/tmp/dotnet-install.sh --channel "7.0" --install-dir "/usr/share/dotnet" # 8.0

export PATH=$PATH:/usr/share/dotnet

dotnet --list-sdks

ls -al

git config --global url.https://github.com/.insteadOf git://github.com/
git clone https://github.com/githubtraining/hellogitworld.git
