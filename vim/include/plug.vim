let g:plug_timeout = 120
call plug#begin('~/.vim/plugged')
Plug 'Align'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'Raimondi/delimitMate'           " Insert mode auto-completion for quotes, parens, brackets, etc
Plug 'SirVer/ultisnips'               " Snippets for vim
"Plug 'Tagbar'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }  " Code completion engine
Plug 'airblade/vim-gitgutter'         " Show git diff in the gutter
Plug 'austintaylor/vim-choosecolor'
Plug 'b4winckler/vim-objc'
Plug 'bkad/CamelCaseMotion'           " CamelCase motion through words
Plug 'bogado/file-line'               " Open file in a given line (file:line)
Plug 'bufexplorer.zip'
Plug 'chrisbra/csv.vim'               " Filetype plugin for CSV
Plug 'christoomey/vim-tmux-navigator'
Plug 'cyphactor/vim-open-alternate'   " Open spec files
Plug 'derekwyatt/vim-scala'
Plug 'dhruvasagar/vim-dotoo'          " org-mode for vim
Plug 'docunext/closetag.vim'          " Close open HTML/XML tags (Crtl-_)
Plug 'editorconfig/editorconfig-vim'  " EditorConfig plugin for vim
Plug 'ekalinin/Dockerfile.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'elzr/vim-json'
Plug 'embear/vim-localvimrc'          " Search local vimrc files (.lvimrc)
Plug 'evanmiller/nginx-vim-syntax'
Plug 'fatih/vim-go'
"Plug 'gerw/vim-latex-suite'
Plug 'gnupg.vim'
Plug 'int3/vim-extradite'
Plug 'janko-m/vim-test'               " Vim wrapper for running tests on different granularities
Plug 'jgdavey/tslime.vim'
Plug 'jgdavey/vim-blockle'            " Toggle ruby blocks
Plug 'jgdavey/vim-turbux'
Plug 'junegunn/goyo.vim'              " Distraction-free writing
Plug 'kana/vim-textobj-user'          " Create your own text objects
Plug 'kchmck/vim-coffee-script'       " CoffeeScript support
Plug 'kien/ctrlp.vim'                 " Fuzzy file, buffer, mru, tag, etc finder (try c-j, c-y + c-o)
Plug 'ludovicchabant/vim-gutentags'
Plug 'matchit.zip'
Plug 'msanders/cocoa.vim'             " Cocoa/Objective C
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'nelstrom/vim-textobj-rubyblock' " A custom text object for selecting ruby blocks (ir, ar)
Plug 'ngmy/vim-rubocop'
Plug 'nono/vim-handlebars'
Plug 'rking/ag.vim'                   " Run ag from vim
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'shime/vim-livedown'
Plug 'sjl/gundo.vim'
Plug 'thoughtbot/pick.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/YankRing.vim'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/loremipsum'
Plug 'vimoutliner/vimoutliner'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'zaiste/tmux.vim'

if has('nvim')
	Plug 'neomake/neomake'            " Asynchronous make
	Plug 'kassio/neoterm'                 " Use the same terminal for everything
endif

Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'wombat256.vim'
Plug 'Chrysoprase'
Plug 'xoria256.vim'

call plug#end()
