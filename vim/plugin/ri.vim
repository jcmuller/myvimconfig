" Vim script to integrate ri Ruby documentation lookup with Vim
" Maintainer:	Daniel Choi <dhchoi@gmail.com>
" License: MIT License (c) 2011 Daniel Choi

if exists("g:RIVimLoaded") || &cp || version < 700
  finish
endif
let g:ri_vim_tool = 'ri_vim '
source /Users/jcmuller/.rbenv/versions/1.8.7-2011.03/lib/ruby/gems/1.8/gems/ri_vim-0.1.8/lib/ri.vim

