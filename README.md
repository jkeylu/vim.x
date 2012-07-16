vim.x
=====

### Install

1. Setup [Vim.x]

* In Linux

```
$ git clone https://github.com/jkeylu/vim.x.git ~/.vim
$ cd ~/.vim
$ git submodule init
$ git submodule update
$ ln -s ~/.vim/vimrc ~/.vimrc
```

* In Widnows

```
C:\>cd "d:\your\user\dir\path"
C:\Users\jKey>git clone https://github.com/jkeylu/vim.x.git .vim
C:\Users\jKey>cd .vim
C:\Users\jKey\.vim>git submodule init
C:\Users\jKey\.vim>git submodule update
C:\Users\jKey\.vim>cd ..
C:\Users\jKey>mklink _vimrc .vim\vimrc
```

2. Install configured bundles
	Launch `vim`, run `:BundleInstall` 
	(or `vim +BundleInstall +qall` for CLI lovers)

