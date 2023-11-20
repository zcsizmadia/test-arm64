#!/bin/bash

sudo apt-get update -q
sudo apt-get install -q -y wget libzstd-dev libicu-dev git
wget https://dot.net/v1/dotnet-install.sh
bash ./dotnet-install.sh --channel "3.1" --install-dir "$HOME/.dotnet" # 3.1
bash ./dotnet-install.sh --channel "5.0" --install-dir "$HOME/.dotnet" # 5.0
bash ./dotnet-install.sh --channel "6.0" --install-dir "$HOME/.dotnet" # 6.0
bash ./dotnet-install.sh --channel "7.0" --install-dir "$HOME/.dotnet" # 7.0
bash ./dotnet-install.sh --channel "7.0" --install-dir "$HOME/.dotnet" # 8.0

echo Done.
