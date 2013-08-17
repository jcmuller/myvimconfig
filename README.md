What is this?
==

This is, finally, a somewhat cleaned up version of my vim configuration.

Init and update submodules.

```bash
$ ln -s $PATH_TO_CLONE/vim ~/.vim
$ ln -s $PATH_TO_CLONE/vimrc ~/.vimrc
$ cd $PATH_TO_CLONE
$ git submodule init
$ gut submodule update
$ vim +BundleInstall
```
