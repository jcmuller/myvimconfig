let g:plug_timeout = 120

call plug#begin('~/.vim/plugged')

" Plug 'chaoren/vim-wordmotion'             " word motions
"Plug 'Tagbar'
"Plug 'bkad/CamelCaseMotion'           " CamelCase motion through words " BUGGY
"Plug 'gerw/vim-latex-suite'
"Plug 'haya14busa/incsearch-easymotion.vim'
"Plug 'haya14busa/incsearch.vim'           " Incremental search
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'              " Fuzzy finder
"Plug 'mileszs/ack.vim'                    " Ack plugin
"Plug 'vim-scripts/YankRing.vim'    " Disabled cause random nvim crashes
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'Raimondi/delimitMate'               " Insert mode auto-completion for quotes, parens, brackets, etc
Plug 'SirVer/ultisnips'                   " Snippets for vim
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer --racer-completer' }  " Code completion engine
Plug 'airblade/vim-gitgutter'             " Show git diff in the gutter
Plug 'austintaylor/vim-choosecolor'
Plug 'b4winckler/vim-objc'
Plug 'bogado/file-line'                   " Open file in a given line (file:line)
Plug 'castwide/solargraph'
Plug 'cespare/vim-toml'
Plug 'chiel92/vim-autoformat'
Plug 'chr4/nginx.vim'
Plug 'chrisbra/csv.vim'                   " Filetype plugin for CSV
Plug 'chrisbra/Colorizer'              " color colornames and codes
Plug 'christoomey/vim-tmux-navigator'
Plug 'cyphactor/vim-open-alternate'       " Open spec files
Plug 'derekwyatt/vim-scala'
Plug 'dhruvasagar/vim-dotoo'              " org-mode for vim
Plug 'docunext/closetag.vim'              " Close open HTML/XML tags (Crtl-_)
Plug 'dyng/ctrlsf.vim'
Plug 'easymotion/vim-easymotion'          " Crazy motions
Plug 'editorconfig/editorconfig-vim'      " EditorConfig plugin for vim
Plug 'ekalinin/Dockerfile.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'elzr/vim-json'
Plug 'embear/vim-localvimrc'              " Search local vimrc files (.lvimrc)
Plug 'fatih/vim-go'
Plug 'int3/vim-extradite'
Plug 'janko-m/vim-test'                   " Vim wrapper for running tests on different granularities
Plug 'jgdavey/tslime.vim'
Plug 'jgdavey/vim-blockle'                " Toggle ruby blocks
Plug 'jgdavey/vim-turbux'
Plug 'jreybert/vimagit'                   " Magit comes to vim
Plug 'junegunn/goyo.vim'                  " Distraction-free writing
Plug 'kana/vim-textobj-user'              " Create your own text objects
Plug 'kchmck/vim-coffee-script'           " CoffeeScript support
Plug 'kien/ctrlp.vim'                     " Fuzzy file, buffer, mru, tag, etc finder (try c-j, c-y + c-o)
Plug 'ludovicchabant/vim-gutentags'
Plug 'merlinrebrovic/focus.vim'
Plug 'mhinz/vim-grepper'
Plug 'maralla/vim-toml-enhance', { 'depends': 'cespare/vim-toml' }
Plug 'msanders/cocoa.vim'                 " Cocoa/Objective C
Plug 'mxw/vim-jsx'
Plug 'nelstrom/vim-textobj-rubyblock'     " A custom text object for selecting ruby blocks (ir, ar)
"Plug 'ngmy/vim-rubocop'
Plug 'nono/vim-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'phb1/gtd.vim'                       " Getting Things Done
Plug 'reedes/vim-pencil'
Plug 'robertbasic/vim-hugo-helper'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
"Plug 'scrooloose/syntastic'
Plug 'shime/vim-livedown'
Plug 'sjl/gundo.vim'
Plug 'slim-template/vim-slim'
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
Plug 'tpope/vim-rhubarb'  " Github support for Fugitive"
Plug 'tpope/vim-surround'
Plug 'vektorlab/slackcat', { 'rtp': 'contrib/vim-slackcat' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-python/python-syntax'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'vim-scripts/loremipsum'
Plug 'vim-scripts/gnupg.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'vimoutliner/vimoutliner'
Plug 'wincent/ferret'
Plug 'w0rp/ale' " Async syntax highlighting. SLOW.
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'zaiste/tmux.vim'
Plug 'zimbatm/haproxy.vim'
Plug 'leafgarland/typescript-vim'

" UI Plugins
Plug 'rhysd/nyaovim-popup-tooltip'

if has('nvim')
  "Plug 'neomake/neomake'            " Asynchronous make
  Plug 'kassio/neoterm'                 " Use the same terminal for everything
  Plug 'Shougo/deoplete.nvim',    { 'do': ':UpdateRemotePlugins' }
endif

" Colors
"Plug 'altercation/vim-colors-solarized'
"Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'
"Plug 'vim-scripts/Chrysoprase'
"Plug 'vim-scripts/wombat256.vim'
"Plug 'vim-scripts/xoria256.vim'

call plug#end()
