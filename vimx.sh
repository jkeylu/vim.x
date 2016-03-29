chvimrc() {
    if [[ -z $1 ]]; then
        echo "Usage: chvimrc [x|m]"
        echo "Current vimrc version is: "
        ls -G -l ~/.vim/vimrc
    else
        rm ~/.vim/vimrc

        if [[ $1 = "x" ]]; then
            pushd ~/.vim/ > /dev/null
            ln -s vimrc.vim vimrc
            popd > /dev/null

        elif [[ $1 = "m" ]]; then
            pushd ~/.vim/ > /dev/null
            ln -s vimrc_mini.vim vimrc
            popd > /dev/null
        fi

        echo ".vimrc has been switched to: "
        ls -G -l ~/.vim/vimrc
    fi
}
