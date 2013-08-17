" {{{ Basics
" Turn off compatibility with VI.
set nocompatible
" }}}
" {{{ Vundle setup
" Use vundle to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
let g:vundle_default_git_proto="git"
" Let vundle manage itself
Bundle "gmarik/vundle"
" }}}
" {{{ Vundle plugins
" Awesome status line
Bundle "Lokaltog/powerline"
" Insert mode auto-completion for quotes, parens, brackets, etc
Bundle "Raimondi/delimitMate"
" Snippets for vim
Bundle "SirVer/ultisnips"
" Code completion engine
Bundle "Valloric/YouCompleteMe"
" Show git diff in the gutter
Bundle "airblade/vim-gitgutter"
" CamelCase motion through words
Bundle "bkad/CamelCaseMotion"
" Open file in a given line (file:line)
Bundle "bogado/file-line"
" Filetype plugin for CSV
Bundle "chrisbra/csv.vim"
" Close open HTML/XML tags (Crtl-_)
" Bundle "docunext/closetag.vim"
" EditorConfig plugin for vim
Bundle "editorconfig/editorconfig-vim"
" Search local vimrc files (.lvimrc)
Bundle "embear/vim-localvimrc"
Bundle "gerw/vim-latex-suite"
" "Go-to-File"
Bundle "git://git.wincent.com/command-t"
" Toggle ruby blocks
Bundle "jgdavey/vim-blockle"
" Create your own text objects
Bundle "kana/vim-textobj-user"
" CoffeeScript support
Bundle "kchmck/vim-coffee-script"
" Fuzzy file, buffer, mru, tag, etc finder (try c-j, c-y + c-o)
Bundle "kien/ctrlp.vim"
" Run ack from vim
Bundle "mileszs/ack.vim"
" Cocoa/Objective C
Bundle "msanders/cocoa.vim"
" A custom text object for selecting ruby blocks (ir, ar)
Bundle "nelstrom/vim-textobj-rubyblock"
Bundle "nono/vim-handlebars"
Bundle "scrooloose/nerdcommenter"
Bundle "scrooloose/nerdtree"
Bundle "scrooloose/syntastic"
Bundle "sjl/gundo.vim"
Bundle "thiderman/nginx-vim-syntax"
Bundle "tpope/vim-abolish"
Bundle "tpope/vim-bundler"
Bundle "tpope/vim-commentary"
Bundle "tpope/vim-cucumber"
Bundle "tpope/vim-dispatch"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-haml"
Bundle "tpope/vim-ragtag"
Bundle "tpope/vim-rails"
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-surround"
Bundle "vim-ruby/vim-ruby"
Bundle "vim-scripts/YankRing.vim"
Bundle "vim-scripts/argtextobj.vim"
Bundle "vim-scripts/loremipsum"
Bundle "vimoutliner/vimoutliner"
Bundle "matchit.zip"
Bundle "imaps.vim"
Bundle "gnupg.vim"
" }}}
" {{{ Indent and spacing
" All nice indent options
set autoindent
set cindent
set cinkeys-=0# " don't force # indentation
set copyindent	"copy the previous indentation on autoindenting
set expandtab
"set noexpandtab
set shiftwidth=2 "Number of spaces to use for each step of (auto)indent
set smartindent
set smarttab "use shiftwidth
set softtabstop=2 "Number of spaces that a <Tab> counts for while editing
set tabstop=2 "Number of spaces that a <Tab> in the file counts for
" }}}
" {{{ Search
set hlsearch "highlight search term
set incsearch "search as you type
set nowrapscan "Only search forward in buffer.
" }}}
" {{{
set background=light
"set background=dark
set backup "do create backup files
set backspace=indent,eol,start "allow backspace to work across inserts and newlines.
"set cmdheight=2 "Number of screen lines to use for the command line
set encoding=utf-8
set fileformats=unix,dos,mac
set laststatus=2 "don't combine status line with command line
set mouse=a "n "a all modes, n normal mode, v visual mode
set nolinebreak "don't break line after n characters (usually 70 unless otherwise spec'd)
set number "show line numbers
set showmatch "highlight matching parenthesis, brace, bracket, etc.
set splitbelow "open help, et al, horizontally below, rather than vertically to the right
set switchbuf=useopen,usetab
set tagbsearch "Binary tag search
"set term=xterm
set textwidth=95
set colorcolumn=95
set viminfo='10,\"100,:20,%,n~/.viminfo
set wrapmargin=0
set diffopt=context:3,iwhite,filler "diff options
" }}}
" {{{ mapleader
let mapleader = ","
" }}}
" {{{ Syntax
" Check for version
if v:version >= 600
	syntax enable
	filetype on
	filetype indent on
	filetype plugin on
	filetype plugin indent on
else
	syntax on
endif
" "}}}
" {{{ List and tabline
if v:version >= 700
	set list
	set listchars=tab:\|\-,trail:_,extends:>,precedes:<,nbsp:@
	set showtabline=2 "always show tab line.
endif
" }}}
" {{{ GPG
if v:version >= 700
	let g:GPGPreferArmor = 1
	let g:GPGPreferSigned = 1
	let g:GPGDefaultRecipients = [$USER]
endif
" }}}
" {{{ Persistent undo
if has('persistent_undo')
	set undofile
	set undodir=~/.vimundo
endif
" }}}
" {{{ Statusline... or Powerline
if v:version >= 700
	if !has('gui_running')
		if has('statusline')
			set statusline=t%{ShowTab()}\ %l/%L\ %P\ %f%M\ %y\ \ %{fugitive#statusline()}\ %c%V\ %r%=File:%n\ %a
			"set statusline=t%{ShowTab()}\ %l\/%L\ %c%V\ %f%M\ \ %y%=F\i\l\e\:%n\ %a
		endif
	else
		set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
	endif
else
	if has('statusline')
		set statusline=t%{ShowTab()}\ %l\/%L\ %c%V\ %f%M\ \ %y%=F\i\l\e\:%n\ %a
	endif
endif
" }}}
" {{{ Spell
if has('spell')
	set spell spelllang=en_us "spell checking enabled

	au FileType gitconfig set nospell
	au FileType man set nospell
	au FileType netrw set nospell
	" au FileType taglist set nospell
	au FileType crontab set nospell
	au FileType gitcommit set nolist
endif
" }}}
" {{{ Scroll
" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=2

set sidescrolloff=5
set sidescroll=15
" }}}
" {{{ Hidden
" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden
" }}}
" {{{ Wildmenu
" Better command-line completion
set wildmenu
set wildignore=*.swp,*.bak,*~,*.pyc,*.class,.git/,build/**
" }}}
" {{{ Showcmd
" Show partial commands in the last line of the screen
set showcmd
" }}}
" {{{ Case in search
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" }}}
" {{{ Confirm
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" }}}
" {{{ Visual bell
" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
set t_vb=
" }}}
" {{{ Time outs
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
" }}}
" {{{ Filetype autocmds
"au BufDelete,BufWritePost .vimrc source ~/.vimrc
"au BufDelete .vimrc source ~/.vimrc

au BufRead *.tex setl makeprg=pdflatex\ %
au BufRead,BufNewFile *.pde setfiletype arduino
au BufRead,BufNewFile *.ino setfiletype arduino
au BufRead,BufWinEnter *.md set ft=markdown
au BufRead,BufWinEnter *.jelly set ft=xml
au BufRead,BufWinEnter *.hbs set ft=handlebars
au BufRead Glossary.md set foldmethod=expr foldexpr=getline(v:lnum)=~'^#'?'>1':0&&getline(v:lnum+1)=~'^#'?'<1':1

" Remove any trailing white space on save
au BufWritePre * :call <SID>StripTrailingWhitespace()

au BufWritePost *.dot make
au BufWritePost *tex make

au BufReadPost *
			\ if expand("<afile>:p:h") !=? $TEMP |
			\   if line("'\"") > 0 && line("'\"") <= line("$") |
			\     exe "normal g`\"" |
			\     let b:doopenfold = 1 |
			\   endif |
			\ endif

" Need to postpone using "zv" until after reading the modelines.
au BufWinEnter *
			\ if exists("b:doopenfold") |
			\   unlet b:doopenfold |
			\   exe "normal zv" |
			\ endif

autocmd BufWinEnter *.feature setl makeprg=bundle\ exec\ cucumber\ \"%:p\"
autocmd FileType ruby
      \ if expand('%') =~# '_test\.rb$' |
      \   compiler rubyunit | setl makeprg=bundle\ exec\ testrb\ \"%:p\" |
      \ elseif expand('%') =~# '\.feature' |
      \   compiler cucumber | setl makeprg=bundle\ exec\ cucumber\ \"%:p\" |
      \ elseif expand('%') =~# '_spec\.rb$' |
      \   compiler rspec | setl makeprg=bundle\ exec\ rspec\ \"%:p\" |
      \ else |
      \   compiler ruby | setl makeprg=ruby\ -wc\ \"%:p\" |
      \ endif

au FileType dot setl makeprg=dot\ -Tpdf\ -O\ % noet sw=4 ts=4
au FileType java setlocal omnifunc=javacomplete#Complete completefunc=javacomplete#CompleteParamsInfo et sw=4 ts=4
au FileType perl setl makeprg=perl\ -c\ % noet sw=4 ts=4
au FileType tex setl makeprg=pdflatex\ %
"au FileType ruby set tags=./tags,tags,~/Development/ChallengePost/tags
au FileType c,cpp,objc setl nolist noet sw=4 ts=4
au FileType crontab setl nobackup nowritebackup
au FileType perl,javascript,json,ruby inoremap <buffer>  {<CR>  {<CR>}<Esc>O
au FileType perl,javascript,json,ruby vnoremap <buffer>  {<CR> s{<CR>}<Esc>kp=iB
au FileType html inoremap <buffer> <Leader>r :!open %<Cr>
au FileType vo_base setl nolist


" Set omnicomplete to a general thing if plugin doesn't implement it already
if has("autocmd") && exists("+omnifunc")
	au Filetype *
				\	if &omnifunc == "" |
				\		setlocal omnifunc=syntaxcomplete#Complete |
				\	endif
endif
" }}}
" {{{ Mappings
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

"" Don't use arrow keys
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

nmap <Leader>a :Ack<space>
" Run ack against the visually selected text
nmap <Leader>A vaw"xy:Ack <C-R>x

" Search visually selected text
vmap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
vmap # :<C-u>call <SID>VSetSearch()<CR>?<CR>

" Search
noremap ;; :%s:::g<Left><Left><Left>
noremap ;' :%s:::gc<Left><Left><Left><Left>

" Select previously pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

noremap! <C-A> <Home>
noremap! <C-E> <End>
cnoremap <C-K> <C-U>
noremap! <C-F> <Right>
noremap! <C-B> <Left>

inoremap {<cr> {<cr>}<ESC>O

" Saving quicker
" Normal mode
nnoremap ;w :w<cr>
" Insert mode: Ctrl-S
inoremap <C-S> <Esc>:w<cr>

" OMG! How did I not know about this earlier?
"noremap : q:I

" Find merge diffs
"nnoremap <Leader>fd /[<=>]\{3\}<cr>
"}}}
" {{{ Custom Functions
func! <SID>StripTrailingWhitespace()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endf

func! s:VSetSearch()
	let temp = @@
	norm! gvy
	let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
	let @@ = temp
endf

func! ShowTab()
	let TabLevel = (indent('.') / &ts )
	if TabLevel == 0
		let TabLevel='*'
	endif
	return TabLevel
endf

func! ShowFuncName()
	let lnum = line(".")
	let col = col(".")
	echohl ModeMsg
	echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
	echohl None
	call search("\\%" . lnum . "l" . "\\%" . col . "c")
endf
"map <Leader>f :call ShowFuncName() <CR>

" }}}
" {{{ Plugin configuration
" {{{ closetag
autocmd FileType html,eruby let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,eruby source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
" }}}
" {{{ Gundo
nnoremap <F6> :GundoToggle<CR>
" }}}
" {{{ Netrw
let g:netrw_http_cmd = "wget -q -O"
" }}}
" {{{ Perl stuff
let perl_include_pod = 1
let perl_extended_vars = 1
let perl_want_scope_in_variables = 1
"let perl_fold = 1
"let perl_fold_blocks = 1
" }}}
" {{{ CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e

omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

sunmap w
sunmap b
sunmap e
" }}}
" {{{ Syntastic
:sign define SyntasticError text=> linehl=Error texthl=SpecialKey
let g:syntastic_aggregate_errors = 1 " Combine errors form different checkers
let g:syntastic_auto_jump = 0 " SO important
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1

let g:syntastic_error_symbol = '✗>'
let g:syntastic_warning_symbol = '!>'
" }}}
" {{{ Ultisnips config
let g:UltiSnipsExpandTrigger='<C-j>'
" }}}
" {{{ Command-T mappings
nnoremap <silent> <Leader>t :CommandT<CR>
nnoremap <silent> <Leader>b :CommandTBuffer<CR>
nnoremap <silent> <Leader>j :CommandTJump<CR>
nnoremap <silent> <Leader>T :CommandTTag<CR>
nnoremap <silent> <Leader>f :CommandTFlush<CR>
" }}}
" {{{ NERDTree
nnoremap <space><space> :NERDTreeToggle<cr>
nnoremap <space>f :NERDTreeFind<cr>
" Open NERDtree when no file was specified
"autocmd vimenter * if !argc() | NERDTree | endif
" }}}
" {{{ Block Toggle (blockle)
let g:blockle_mapping = '<Leader>l'
" }}}
" {{{ Vim GitGutter
let g:gitgutter_on_bufenter = 1
let g:gitgutter_all_on_focusgained = 0
let g:gitgutter_highlight_lines = 0
" }}}
" {{{ CTRLP
let g:ctrlp_map = '<Leader>p'
"let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux"
" }}}
" {{{  localvimrc
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0
let g:localvimrc_blacklist = $HOME . "/Development/OSS/.*"
"let g:localvimrc_debug = 1
" }}}
" }}}
" {{{ Color settings
set t_Co=256
colo Tomorrow
" }}}

" vim:tw=0:ts=4:sw=4:noet:nolist:foldmethod=marker
