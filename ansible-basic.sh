#!/usr/bin/env bash

ANSIBLE=1  \
DEVEL=1    \
DOTFILES=1 \
VIM=1      \
CLANG=1    \
  vagrant up --provision
