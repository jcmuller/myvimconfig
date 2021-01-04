let g:plug_timeout = 120

call plug#begin('~/.vim/plugged')

"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer --racer-completer' }  " Code completion engine
"Plug 'bkad/CamelCaseMotion'           " CamelCase motion through words BUGGY
"Plug 'chaoren/vim-wordmotion'             " word motions
"Plug 'gerw/vim-latex-suite'
"Plug 'haya14busa/incsearch-easymotion.vim'
"Plug 'haya14busa/incsearch.vim'           " Incremental search
"Plug 'mileszs/ack.vim'                    " Ack plugin
"Plug 'ngmy/vim-rubocop'
"Plug 'ryanoasis/vim-devicons'
"Plug 'scrooloose/syntastic'
"Plug 'vim-scripts/YankRing.vim'    " Disabled cause random nvim crashes
Plug 'Konfekt/vim-mutt-aliases'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'Raimondi/delimitMate'               " Insert mode auto-completion for quotes, parens, brackets, etc
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim',    { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neomru.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'             " Show git diff in the gutter
Plug 'aklt/plantuml-syntax'
Plug 'austintaylor/vim-choosecolor'
Plug 'b4winckler/vim-objc'
Plug 'bogado/file-line'                   " Open file in a given line (file:line)
Plug 'castwide/solargraph'
Plug 'cespare/vim-toml'
Plug 'chiel92/vim-autoformat'
Plug 'chr4/nginx.vim'
Plug 'chrisbra/Colorizer'              " color colornames and codes
Plug 'chrisbra/csv.vim'                   " Filetype plugin for CSV
Plug 'christoomey/vim-tmux-navigator'
Plug 'cyphactor/vim-open-alternate'       " Open spec files
" Plug 'dense-analysis/ale' " Async syntax highlighting.
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
Plug 'fszymanski/fzf-quickfix',           { 'on': '<Plug>(fzf-quickfix)' }
Plug 'google/vim-jsonnet'
Plug 'hashivim/vim-terraform'
Plug 'herringtondarkholme/yats.vim'       " Yet Another TypeScript Syntax
Plug 'int3/vim-extradite'
Plug 'janko-m/vim-test'                   " Vim wrapper for running tests on different granularities
Plug 'jgdavey/tslime.vim',                 { 'branch': 'main' }
Plug 'jgdavey/vim-blockle'                " Toggle ruby blocks
Plug 'jgdavey/vim-turbux',                 { 'branch': 'main' }
Plug 'jreybert/vimagit'                   " Magit comes to vim
Plug 'junegunn/fzf',                      { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                   " Fuzzy finder
Plug 'junegunn/goyo.vim'                  " Distraction-free writing
Plug 'jvirtanen/vim-hcl'
Plug 'kana/vim-textobj-user'              " Create your own text objects
Plug 'kchmck/vim-coffee-script'           " CoffeeScript support
Plug 'kien/ctrlp.vim'                     " Fuzzy file, buffer, mru, tag, etc finder (try c-j, c-y + c-o)
"Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'maralla/vim-toml-enhance',          { 'depends': 'cespare/vim-toml' }
Plug 'markcornick/vim-bats'
Plug 'merlinrebrovic/focus.vim'
Plug 'mhinz/vim-grepper'
Plug 'msanders/cocoa.vim'                 " Cocoa/Objective C
Plug 'mxw/vim-jsx'
Plug 'nelstrom/vim-textobj-rubyblock'     " A custom text object for selecting ruby blocks (ir, ar)
Plug 'neoclide/coc.nvim',                 { 'branch': 'release' }
Plug 'nono/vim-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'phb1/gtd.vim'                       " Getting Things Done
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-pencil'
Plug 'rhysd/vim-github-actions'
Plug 'rhysd/vim-grammarous'
Plug 'robertbasic/vim-hugo-helper'
Plug 'rust-lang/rust.vim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'shime/vim-livedown'
Plug 'sjl/gundo.vim'
Plug 'sirtaj/vim-openscad'
Plug 'slim-template/vim-slim'
Plug 'thoughtbot/pick.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'  " Github support for Fugitive"
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vektorlab/slackcat', { 'rtp': 'contrib/vim-slackcat' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-python/python-syntax'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'vim-scripts/dbext.vim'
Plug 'vim-scripts/gnupg.vim'
Plug 'vim-scripts/loremipsum'
Plug 'vim-scripts/matchit.zip'
Plug 'vimoutliner/vimoutliner'
Plug 'wincent/ferret' " Enhanced multi file search
Plug 'yuki-ycino/fzf-preview.vim',               { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'zaiste/tmux.vim'
Plug 'zimbatm/haproxy.vim'

" UI Plugins
Plug 'rhysd/nyaovim-popup-tooltip'

if has('nvim')
  "Plug 'neomake/neomake'            " Asynchronous make
  Plug 'kassio/neoterm'                 " Use the same terminal for everything
else
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Colors
"Plug 'jcmuller/vim-tomorrow-theme'
Plug 'jsit/vim-tomorrow-theme'

call plug#end()
