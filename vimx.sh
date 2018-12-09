#!/usr/bin/env bash

chvimrc() {
    if [[ -z $1 ]]; then
        echo "Usage: chvimrc [s|l]"
        echo "Current vimrc version is: "
        ls -G -l ~/.vim/vimrc
    else
        rm -rf ~/.vim/vimrc

        if [[ $1 = "s" ]]; then
            pushd ~/.vim/ > /dev/null
            ln -s simple.vim vimrc
            popd > /dev/null

        elif [[ $1 = "l" ]]; then
          pushd ~/.vim/ > /dev/null
          ln -s lite.vim vimrc
          popd > /dev/null
        fi

        echo ".vimrc has been switched to: "
        ls -G -l ~/.vim/vimrc
    fi
}

lvim() {
  vim -u ~/.vim/lite.vim "$@"
}
