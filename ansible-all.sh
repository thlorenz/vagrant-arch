#!/usr/bin/env bash

ANSIBLE=1  \
CLANG=1    \
LLDB=1     \
PERF=1     \
DEVEL=1    \
DOTFILES=1 \
VIM=1      \
IOJS=1     \
  ansible-playbook ansible/arch.yml
