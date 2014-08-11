#!/bin/bash

# This script assumes it's run as root, and has only been tested on Ubuntu.
if [ `whoami` != "root" ]; then
  echo "This install script must be run as root, i.e. sudo ./install-lldb.sh"
  exit 1
fi

# Building with clang is so much faster.
echo 'export CC=clang' > .bash_aliases
echo 'export CXX=clang++' >> .bash_aliases
echo 'export GYP_DEFINES="clang=1"' >> .bash_aliases

. .bash_aliases

# linux-tools comes with perf 3.16.1 https://www.archlinux.org/packages/community/i686/perf/
pacman -S --noconfirm linux-tools

perf --version
