" Turn off compatibility with VI.
set nocompatible

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
filetype off
call pathogen#infect()

set autoindent
"set background=light
set background=dark
set backup "do create backup files
set backspace=2 "allow backspace to work across inserts and newlines.
set cindent
set copyindent	"copy the previous indentation on autoindenting
set expandtab
"set noexpandtab
set shiftwidth=2 tabstop=2
set hlsearch "highlight search term
set incsearch "search as you type
set laststatus=2 "don't combine status line with command line
set mouse=a "n "a all modes, n normal mode, v visual mode
set nolinebreak "don't break line after n characters (usually 70 unless otherwise spec'd)
set nowrapscan "Only search forward in buffer.
set number "show line numbers
set showmatch "highlight matching parenthesis, brace, bracket, etc.
set smartindent
set smarttab
set splitbelow "open help, et al, horizontally below, rather than vertically to the right
set switchbuf=useopen,usetab
set tagbsearch "Binary tag search
"set term=xterm
set textwidth=0
set viminfo='10,\"100,:20,%,n~/.viminfo
set wrapmargin=0
set diffopt=context:3,iwhite,filler "diff options
let mapleader = ","

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

if v:version >= 700
	set list
	set listchars=tab:\|\-,trail:_,extends:>,precedes:<,nbsp:@
	set showtabline=2 "always show tab line.

	" gnupg
	let g:GPGPreferArmor = 1
	let g:GPGPreferSigned = 1
	let g:GPGDefaultRecipients = [$USER]
	"let g:GPGExecutable  = ''
	"let g:GPGUseAgent    = 1
	"let g:GPGPreferSymmetric = 1

	if has('statusline')
		set statusline=t%{ShowTab()}\ %l/%L\ %P\ %f%M\ %y\ [%{Tlist_Get_Tagname_By_Line()}]\ %c%V\ %r%=File:%n\ %a
		"set statusline=t%{ShowTab()}\ %l\/%L\ %c%V\ %f%M\ \ %y%=F\i\l\e\:%n\ %a
	endif
else
	if has('statusline')
		set statusline=t%{ShowTab()}\ %l\/%L\ %c%V\ %f%M\ \ %y%=F\i\l\e\:%n\ %a
	endif
endif

if has('persistent_undo')
	set undofile
	set undodir=~/.vimundo
endif

if has('spell')
	set spell spelllang=en_us "spell checking enabled

	au FileType gitconfig set nospell
	au FileType man set nospell
	au FileType netrw set nospell
	au FileType taglist set nospell
	au FileType crontab set nospell
	au FileType gitcommit set nolist
endif

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=2

set sidescrolloff=5
set sidescroll=15

"set cmdheight=2

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Better command-line completion
set wildmenu
set wildignore=*.swp,*.bak,*~,*.pyc,*.class

" Show partial commands in the last line of the screen
set showcmd

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
set t_vb=

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

runtime! ftplugin/man.vim

"au BufDelete,BufWritePost .vimrc source ~/.vimrc
"au BufDelete .vimrc source ~/.vimrc

au BufRead,BufNewFile *.include,*.inc,*.template set filetype=html

au BufRead *.tex makeprg=pdflatex\ %

au BufWritePre * :%s/\s\+$//e

au BufWritePost 0.wiki*,wiki*,vimperator-*wiki*,pentadactyl*wiki* w! /tmp/copy_of_last_edited_wiki_topic.wiki
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

au FileType dot set makeprg=dot\ -Tpdf\ -O\ % noet sw=4 ts=4
au FileType java setlocal omnifunc=javacomplete#Complete completefunc=javacomplete#CompleteParamsInfo noet sw=4 ts=4
au FileType perl set makeprg=perl\ -c\ % noet sw=4 ts=4
au FileType tex set makeprg=pdflatex\ %
"au FileType ruby set tags=./tags,tags,~/Development/ChallengePost/tags
au FileType objc set noet sw=4 ts=4
au FileType crontab set nobackup nowritebackup
au FileType perl,javascript,json,ruby inoremap <buffer>  {<CR>  {<CR>}<Esc>O
au FileType perl,javascript,json,ruby vnoremap <buffer>  {<CR> s{<CR>}<Esc>kp=iB

au FileType html inoremap <buffer> <Leader>r :!open %<Cr>

" Set omnicomplete to a general thing if plugin doesn't implement it already
if has("autocmd") && exists("+omnifunc")
	au Filetype *
				\	if &omnifunc == "" |
				\		setlocal omnifunc=syntaxcomplete#Complete |
				\	endif
endif


"""""""""""""""""""""""" MAPS
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

"" Don't use arrow keys
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

nmap <Leader>a :Ack
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
inoremap <C-S> <Esc>:w<cr>i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration

" closetag
autocmd FileType html,eruby let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,eruby source ~/.vim/bundle/closetag.vim/plugin/closetag.vim

" Mappings for taglist plugin
map <F3> :Tlist<CR>
map <F4> :TlistHighlightTag<CR>
map <F5> :TlistShowTag<CR>
let Tlist_Sort_Type = "name"
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'

map <F2> :TagbarToggle<CR>
let g:tagbar_ctags_bin='/usr/local/bin/ctags'

"let g:SuperTabDefaultCompletionType = "context"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vsearch.vim
" Visual mode search
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

let g:netrw_http_cmd = "wget -q -O"

" Perl stuff
let perl_include_pod = 1
let perl_extended_vars = 1
let perl_want_scope_in_variables = 1
"let perl_fold = 1
"let perl_fold_blocks = 1

set ffs=unix,dos,mac

" Color settings
set t_Co=256
if filereadable($HOME . '/.vim/colors/xoria256.vim')
	colo xoria256
else
	colo default
endif

let g:LustyJugglerSuppressRubyWarning = 1

" vim:tw=0:ts=4:sw=4:noet:nolist:
