#!/bin/bash

repository=~/dotfiles

targets=(
    .login
    .tcshrc
    .emacs
    .gitconfig
    .less
    .lesskey
    .screenrc
    .ctags
)

for target in "${targets[@]}"; do
    ln -sf $repository/$target ~/$target
done
