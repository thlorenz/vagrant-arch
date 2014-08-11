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

# We are gonna need lots of space
echo "++ Warning increasing /tmp space to allow compilation ++"
echo "Current Setting"
df -h

mount -o remount,size=10G tmpfs /tmp/

echo "Changed Setting"
df -h

# In order to build lldb we need clang, so install older version first
pacman -Sy --noconfirm clang clang-analyzer 
# llvm-libs clang-tools-extra llvm-ocaml

# building with cmake and ninja is the fastest
pacman -S --noconfirm cmake ninja 

# more dependencies
pacman -S --noconfirm swig python2

# ensure we use python2 since lldb depends on StringIO to build
(cd /usr/bin && rm -rf python && ln -s python2 python)

cmake .. -G Ninja -Wno-dev

mkdir -p dev/c && cd dev/c
svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm
cd llvm/tools
svn co http://llvm.org/svn/llvm-project/cfe/trunk clang
svn co http://llvm.org/svn/llvm-project/lldb/trunk lldb
mkdir ../build && cd ../build

echo "If you see this error: 'Target: x86_64-unknown-linux-gnu' run the following command from the current directory"
echo "/usr/bin/clang++   -DGTEST_HAS_RTTI=0 -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -fPIC -fvisibility-inlines-hidden -Wall -W -Wno-unused-parameter -Wwrite-strings -Wmissing-field-initializers -pedantic -Wno-long-long -Wcovered-switch-default -Wnon-virtual-dtor -std=c++11 -fcolor-diagnostics -fdata-sections -Ilib/Target/ARM -I../lib/Target/ARM -Iinclude -I../include    -fno-exceptions -fno-rtti -MMD -MT lib/Target/ARM/CMakeFiles/LLVMARMCodeGen.dir/ARMFastISel.cpp.o -MF lib/Target/ARM/CMakeFiles/LLVMARMCodeGen.dir/ARMFastISel.cpp.o.d -o lib/Target/ARM/CMakeFiles/LLVMARMCodeGen.dir/ARMFastISel.cpp.o -c ../lib/Target/ARM/ARMFastISel.cpp"

ninja install

lldb --version
