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

MAKE_PARALLEL=`nproc`
export Make_PARALLEL

# In order to build lldb we need clang, so install older version first
pacman -Sy --noconfirm clang clang-analyzer clang-tools-extra llvm-libs llvm-ocaml

# Install latest version (svn/trunk)
yaourt -S --noconfirm llvm-toolchain-svn

lldb --version
