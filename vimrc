" Juan C. Muller's .vimrc
" {{{ Basics
" Turn off compatibility with VI.
set nocompatible
" }}}
" {{{ Vundle
" {{{ Setup
" Use vundle to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
let g:vundle_default_git_proto="git"
" Let vundle manage itself
Bundle "gmarik/vundle"
" }}}
" {{{ Plugins
Bundle "b4winckler/vim-objc"
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
Bundle "bling/vim-airline"
" Open file in a given line (file:line)
Bundle "bogado/file-line"
" Filetype plugin for CSV
Bundle "chrisbra/csv.vim"
Bundle 'christoomey/vim-tmux-navigator'
" Close open HTML/XML tags (Crtl-_)
Bundle "docunext/closetag.vim"
" EditorConfig plugin for vim
Bundle "editorconfig/editorconfig-vim"
" Search local vimrc files (.lvimrc)
Bundle "embear/vim-localvimrc"
"Bundle "gerw/vim-latex-suite"
" Toggle ruby blocks
Bundle "jgdavey/tslime.vim"
Bundle "jgdavey/vim-blockle"
Bundle "jgdavey/vim-turbux"
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
Bundle "tpope/vim-cucumber"
Bundle "tpope/vim-dispatch"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-haml"
Bundle "tpope/vim-ragtag"
Bundle "tpope/vim-rails"
Bundle "tpope/vim-rbenv"
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-surround"
Bundle "vim-ruby/vim-ruby"
Bundle "vim-scripts/YankRing.vim"
Bundle "vim-scripts/argtextobj.vim"
Bundle "vim-scripts/loremipsum"
Bundle "vimoutliner/vimoutliner"
Bundle "zaiste/tmux.vim"
Bundle "Tagbar"
Bundle "bufexplorer.zip"
Bundle "gnupg.vim"
"Bundle "imaps.vim"
Bundle "matchit.zip"
" {{{ Colors
Bundle "altercation/vim-colors-solarized"
Bundle "chriskempson/base16-vim"
Bundle "chriskempson/vim-tomorrow-theme"
Bundle "wombat256.vim"
Bundle "Chrysoprase"
Bundle "xoria256.vim"
" }}}
" }}}
" }}}
" {{{ Indent and spacing
" All nice indent options
set autoindent
set cindent
set cinkeys-=0# " don't force # indentation
set copyindent	"copy the previous indentation on autoindenting
set expandtab
"set noexpandtab
set shiftround "Round indent to multiple of 'shiftwidth'
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
" {{{ Global settings
" set autoread     "refresh file automatically if changed
set background=light
"set background=dark
set backup "do create backup files
set backspace=indent,eol,start "allow backspace to work across inserts and newlines.
"set cmdheight=2 "Number of screen lines to use for the command line
set encoding=utf-8
set fileformats=unix,dos,mac
set history=1000
"set iskeyword+=_,$,@,%,#                        "not word dividers
set laststatus=2 "don't combine status line with command line
set mouse=a "n "a all modes, n normal mode, v visual mode
set noautowrite "Don't write the contents of the file, if it has been modified, on each
set nolinebreak "don't break line after n characters (usually 70 unless otherwise spec'd)
set noshowmode
set number "show line numbers
set splitbelow "open help, et al, horizontally below, rather than vertically to the right
set splitright
set switchbuf=useopen,usetab "control behavior when switching buffers.
set tagbsearch "Binary tag search
"set term=xterm
set textwidth=95
set ttymouse=xterm2
set colorcolumn=95
set viminfo='10,\"100,:20,%,n~/.vim/var/info
set wrapmargin=0
set diffopt=context:3,iwhite,filler "diff options
" }}}
" {{{ mapleader
let mapleader = ","
" }}}
" {{{ match
set matchpairs+=<:>
set showmatch "highlight matching parenthesis, brace, bracket, etc.
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
	set listchars=tab:\|\-,trail:•,extends:>,precedes:<,nbsp:@
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
	set undodir=~/.vim/var/undo
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
au BufRead,BufNewFile *.pde setlocal ft=arduino
au BufRead,BufNewFile *.ino setlocal ft=arduino
au BufRead,BufWinEnter *.md setlocal ft=markdown
au BufRead,BufWinEnter *.jelly setlocal ft=xml
au BufRead,BufWinEnter *.hbs set ft=handlebars
au BufRead,BufWinEnter Glossary.md setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^#'?'>1':0&&getline(v:lnum+1)=~'^#'?'<1':1
au BufRead,BufNewFile *.tmux setlocal ft=tmux

" Remove any trailing white space on save
"au BufWritePre * :call <SID>StripTrailingWhitespace()
au BufWritePre * :call StripTrailingWhitespace()

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
" Quickly edit/source .vimrc
noremap <leader>ve :edit $HOME/.vimrc<CR>
noremap <leader>vs :source $HOME/.vimrc<CR>

" Yank(copy) to system clipboard
noremap <leader>y "+y

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" nnoremap <C-L> :nohl<CR><C-L>
nnoremap <Leader>l :nohl<cr>:redraw!<cr>

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
func! StripTrailingWhitespace()
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

"func! GetCurrentPath()
"endf

" }}}
" {{{ Plugin configuration
" {{{ Airline
let g:airline_theme = "tomorrow"
let g:airline_mode_map = {
			\ '__' : '-',
			\ 'n'  : 'N',
			\ 'i'  : 'I',
			\ 'R'  : 'R',
			\ 'c'  : 'C',
			\ 'v'  : 'V',
			\ 'V'  : 'V',
			\ '' : 'V',
			\ 's'  : 'S',
			\ 'S'  : 'S',
			\ '' : 'S',
			\ 'h'  : 'H'
			\ }

let g:airline_powerline_fonts = 1

"if !has('gui_running')
"unicode symbols
"let g:airline#extensions#branch#symbol = '⎇ '
"let g:airline#extensions#whitespace#symbol = 'Ξ'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
"let g:airline_linecolumn_prefix = '␊ '
"let g:airline_paste_symbol = 'ρ'

"powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline#extensions#branch#symbol = ' '
"let g:airline#extensions#readonly#symbol = ''
"let g:airline_linecolumn_prefix = ' '
"endif
"let g:airline_section_a       (the mode/paste indicator)
"let g:airline_section_b       (the fugitive/lawrencium branch indicator)
"let g:airline_section_c       (bufferline or filename)
"let g:airline_section_gutter  (readonly, csv)
"let g:airline_section_x       (tagbar, filetype)
"let g:airline_section_y       (fileencoding, fileformat)
"let g:airline_section_z       (percentage, line number, column number)
"let g:airline_section_warning (syntastic, whitespace)
"let g:airline_section_z = ""

" }}}
" {{{ Block Toggle (blockle)
let g:blockle_mapping = '<Leader>L'
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
" {{{ Closetag
autocmd FileType html,eruby let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,eruby source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
" }}}
" {{{ Command-T mappings
"nnoremap <silent> <Leader>t :CommandT<CR>
"nnoremap <silent> <Leader>b :CommandTBuffer<CR>
"nnoremap <silent> <Leader>j :CommandTJump<CR>
"nnoremap <silent> <Leader>T :CommandTTag<CR>
"nnoremap <silent> <Leader>f :CommandTFlush<CR>
" }}}
" {{{ CTRLP
let g:ctrlp_map = '<Leader>p'
"let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux"
" Extensions
let g:ctrlp_extensions = ['tag', 'line']
let g:ctrlp_buftag_ctags_bin = '/usr/local/bin/ctags'

let g:ctrlp_match_window = "bottom,order:ttb,min:1,max:30"
let g:ctrlp_show_hidden = 1

let g:ctrlp_switch_buffer = 'e'
  "e - jump when <cr> is pressed, but only to windows in the current tab.
  "t - jump when <c-t> is pressed, but only to windows in another tab.
  "v - like "e", but jump when <c-v> is pressed.
  "h - like "e", but jump when <c-x> is pressed.
  "E, T, V, H - like "e", "t", "v", and "h", but jump to windows anywhere.
  "0 or <empty> - disable this feature.

nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
nnoremap <silent> <Leader>j :CtrlPJump<CR>
"nnoremap <silent> <Leader>T :CtrlPTag<CR>
nnoremap <silent> <Leader>f :CtrlPClearAllCaches<CR>

"let g:ctrlp_prompt_mappings = {
"\ 'PrtBS()':              ['<bs>', '<c-]>'],
"\ 'PrtDelete()':          ['<del>'],
"\ 'PrtDeleteWord()':      ['<c-w>'],
"\ 'PrtClear()':           ['<c-u>'],
"\ 'PrtSelectMove("j")':   ['<c-j>', '<down>'],
"\ 'PrtSelectMove("k")':   ['<c-k>', '<up>'],
"\ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
"\ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
"\ 'PrtSelectMove("u")':   ['<PageUp>', '<kPageUp>'],
"\ 'PrtSelectMove("d")':   ['<PageDown>', '<kPageDown>'],
"\ 'PrtHistory(-1)':       ['<c-n>'],
"\ 'PrtHistory(1)':        ['<c-p>'],
"\ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
"\ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
"\ 'AcceptSelection("t")': ['<c-t>'],
"\ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
"\ 'ToggleFocus()':        ['<s-tab>'],
"\ 'ToggleRegex()':        ['<c-r>'],
"\ 'ToggleByFname()':      ['<c-d>'],
"\ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
"\ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
"\ 'PrtExpandDir()':       ['<tab>'],
"\ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
"\ 'PrtInsert()':          ['<c-\>'],
"\ 'PrtCurStart()':        ['<c-a>'],
"\ 'PrtCurEnd()':          ['<c-e>'],
"\ 'PrtCurLeft()':         ['<c-h>', '<left>', '<c-^>'],
"\ 'PrtCurRight()':        ['<c-l>', '<right>'],
"\ 'PrtClearCache()':      ['<F5>'],
"\ 'PrtDeleteEnt()':       ['<F7>'],
"\ 'CreateNewFile()':      ['<c-y>'],
"\ 'MarkToOpen()':         ['<c-z>'],
"\ 'OpenMulti()':          ['<c-o>'],
"\ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
"\ }
" }}}
" {{{ Fugitive
nnoremap <leader>ga  :Git add -p<CR>
nnoremap <leader>gb  :Gblame
nnoremap <leader>gc  :Gcommit -v
nnoremap <leader>gd  :Gdiff
nnoremap <leader>gl  :Glog<CR>
nnoremap <leader>gm  :Gmove<space>
nnoremap <leader>gpu :Git push<CR>
nnoremap <leader>gpr :Git pull --rebase<CR>
nnoremap <leader>gr  :Gremove<CR>
nnoremap <leader>gs  :Gstatus<CR>
" }}}
" {{{ GitGutter
let g:gitgutter_on_bufenter = 1
let g:gitgutter_all_on_focusgained = 0
let g:gitgutter_highlight_lines = 0
" }}}
" {{{ Gundo
nnoremap <F6> :GundoToggle<CR>
" }}}
" {{{  localvimrc
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0
let g:localvimrc_blacklist = $HOME . "/Development/OSS/.*"
"let g:localvimrc_debug = 1
" }}}
" {{{ NERDTree
nnoremap <space><space> :NERDTreeToggle<cr>
nnoremap <space>f :NERDTreeFind<cr>
" Open NERDtree when no file was specified
"autocmd vimenter * if !argc() | NERDTree | endif
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
" {{{ Tagbar
" Tagbar mappings
map <F2> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
"let g:tagbar_foldlevel = 3
"let g:tagbar_autoshowtag = 0

" let g:tagbar_iconchars = ['▶', '▼']  "(default on Linux and Mac OS X)
let g:tagbar_iconchars = ['▸', '▾']
" let g:tagbar_iconchars = ['▷', '◢']
" let g:tagbar_iconchars = ['+', '-']  "(default on Windows)

" au VimEnter * nested :call tagbar#autoopen(1)
" au FileType * nested :call tagbar#autoopen(0)
" au BufEnter * nested :call tagbar#autoopen(0)
"
let g:tagbar_type_coffee = {
	\ 'ctagstype' : 'coffee',
	\ 'kinds'     : [
		\ 'c:classes',
		\ 'm:methods',
		\ 'f:functions',
		\ 'v:variables',
		\ 'f:fields',
	\ ]
\ }

let g:tagbar_type_markdown = {
	\ 'ctagstype' : 'markdown',
	\ 'kinds' : [
		\ 'h:Heading_L1',
		\ 'i:Heading_L2',
		\ 'k:Heading_L3'
	\ ]
\ }

" }}}
" {{{ tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" }}}
" {{{ tslime
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars
" }}}
" {{{ turbux
let g:no_turbux_mappings = 1
map <Leader>t <Plug>SendTestToTmux
map <Leader>T <Plug>SendFocusedTestToTmux

let g:turbux_runner  = 'dispatch'      " default: vimux OR tslime OR vim OR dispatch
let g:turbux_command_prefix = 'bundle exec' " default: (empty)
"let g:turbux_command_rspec  = 'rspec'        " default: rspec
"let g:turbux_command_test_unit = 'ruby'     " default: ruby -Itest
"let g:turbux_command_cucumber = 'cucumber'  " default: cucumber
"let g:turbux_command_turnip = 'rspec'       " default: rspec -rturnip
" }}}
" {{{ Ultisnips config
let g:UltiSnipsExpandTrigger='<C-j>'
" }}}
" }}}
" {{{ Color settings
set t_Co=256
colo Tomorrow
" }}}

" vim:tw=0:ts=4:sw=4:noet:nolist:foldmethod=marker
