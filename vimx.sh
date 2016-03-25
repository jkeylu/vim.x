chvimrc() {
    if [[ -z $1 ]]; then
        echo "Usage: chvimrc [x|m]"
        echo "Current vimrc version is: "
        ls -G -l ~/.vim/vimrc
    else
        rm ~/.vim/vimrc

        if [[ $1 = "x" ]]; then
            cd ~/.vim/ && ln -s vimrc.vim vimrc

        elif [[ $1 = "m" ]]; then
            cd ~/.vim/ && ln -s vimrc_mini.vim vimrc
        fi

        echo ".vimrc has been switched to: "
        ls -G -l ~/.vim/vimrc
    fi
}
