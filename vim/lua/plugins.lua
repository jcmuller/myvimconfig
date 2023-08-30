-- vim:foldmethod=marker

-- {{{ Install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
--- }}}

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- tabout {{{
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        -- completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = '`', close = '`' },
          { open = '(', close = ')' },
          { open = '[', close = ']' },
          { open = '{', close = '}' }
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
      }
    end,
    wants = { 'nvim-treesitter' }, -- or require if not used so far
    --after = {'completion-nvim'} -- if a completion plugin is using tabs load it before
  }
  -- }}}

  -- {{{ treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
          custom_captures = {
            -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
            ["foo.bar"] = "Identifier",
          },
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
          --},
          --indent = {
          --enable = true
        },

        refactor = {
          --   highlight_definitions = {
          --     enable = false,
          --     clear_on_cursor_move = false,
          --   },
          --   highlight_current_scope = {
          --     enable = false,
          --   },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = "gnd",
              list_definitions = "gnD",
              list_definitions_toc = "gO",
              goto_next_usage = "<a-*>",
              goto_previous_usage = "<a-#>",
            },
          },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = 'grr',
            },
          },
        },
        auto_install = true,
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
          },
          lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      }
    end
  }

  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use { 'tree-sitter/tree-sitter-bash', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use 'camdencheek/tree-sitter-dockerfile'
  use 'rydesun/tree-sitter-dot'
  use 'tree-sitter/tree-sitter-go'
  use 'camdencheek/tree-sitter-go-mod'
  use 'tree-sitter/tree-sitter-json'
  use 'vigoux/tree-sitter-viml'
  use 'ikatyang/tree-sitter-yaml'
  -- treesitter-context {{{
  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require 'treesitter-context'.setup {
        enable = true,
        max_lines = 0,
        patterns = {
          default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
            'struct',
            'enum',
            'arguments',
            'block',
            'anonymous_function',
            'map',
            'tuple',
          }
        },
      }
    end
  }
  -- }}}
  -- }}}
  --
  -- NEED TO CLEAN THIS UP
  --
  -- filetypes
  -- use 'kchmck/vim-coffee-script' -- CoffeeScript support
  -- use 'msanders/cocoa.vim' -- Cocoa/Objective C
  use 'Fymyte/rasi.vim'
  use 'PotatoesMaster/i3-vim-syntax'
  use 'aklt/plantuml-syntax'
  use 'b4winckler/vim-objc'
  use 'chr4/nginx.vim'
  use 'dart-lang/dart-vim-plugin'
  use 'derekwyatt/vim-scala'
  use 'ekalinin/Dockerfile.vim'
  use 'elzr/vim-json'
  use 'google/vim-jsonnet'
  use 'hashivim/vim-terraform'
  use 'jparise/vim-graphql'
  use 'markcornick/vim-bats'
  use 'mxw/vim-jsx'
  use 'nono/vim-handlebars'
  use 'pangloss/vim-javascript'
  use 'rust-lang/rust.vim'
  use 'sirtaj/vim-openscad'
  use 'towolf/vim-helm'
  use 'vim-python/python-syntax'
  use 'vim-ruby/vim-ruby'
  use 'zaiste/tmux.vim'
  use 'zimbatm/haproxy.vim'
  use { 'jvirtanen/vim-hcl', branch = 'main' }
  use { 'maralla/vim-toml-enhance', requires = 'cespare/vim-toml' }

  -- improvements on netrw
  use 'tpope/vim-vinegar'

  use 'Konfekt/vim-mutt-aliases'
  use 'Raimondi/delimitMate' -- Insert mode auto-completion for quotes, parens, brackets, etc
  use 'Shougo/context_filetype.vim'
  use 'Shougo/denite.nvim'
  use 'Shougo/echodoc.vim'
  use 'Shougo/neomru.vim'
  use 'airblade/vim-gitgutter' -- Show git diff in the gutter
  use 'austintaylor/vim-choosecolor'
  use { 'bogado/file-line', branch = 'main' } -- Open file in a given line (file:line)
  use 'castwide/solargraph'
  use { 'cespare/vim-toml', branch = 'main' }
  use 'chiel92/vim-autoformat'
  use 'chrisbra/Colorizer' -- color colornames and codes
  use 'chrisbra/csv.vim' -- Filetype plugin for CSV
  use 'christoomey/vim-tmux-navigator'
  use 'cyphactor/vim-open-alternate' -- Open spec files
  use 'dhruvasagar/vim-dotoo' -- org-mode for vim
  use 'docunext/closetag.vim' -- Close open HTML/XML tags (Crtl-_)
  use 'dstein64/vim-startuptime'
  use 'easymotion/vim-easymotion' -- Crazy motions
  use 'editorconfig/editorconfig-vim' -- EditorConfig plugin for vim
  use 'elixir-lang/vim-elixir'
  use 'embear/vim-localvimrc' -- Search local vimrc files (.lvimrc)
  use 'eraserhd/vim-ios'
  use 'fatih/vim-go'
  use 'herringtondarkholme/yats.vim' -- Yet Another TypeScript Syntax
  use 'int3/vim-extradite'
  use 'janko-m/vim-test' -- Vim wrapper for running tests on different granularities
  use { 'jgdavey/tslime.vim', branch = 'main' }
  use 'jgdavey/vim-blockle' -- Toggle ruby blocks
  use { 'jgdavey/vim-turbux', branch = 'main' }
  use 'jreybert/vimagit' -- Magit comes to vim
  use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
  use 'junegunn/fzf.vim' -- Fuzzy finder
  use 'junegunn/goyo.vim' -- Distraction-free writing
  use 'kana/vim-textobj-user' -- Create your own text objects
  use 'kien/ctrlp.vim' -- Fuzzy file, buffer, mru, tag, etc finder (try c-j, c-y + c-o)
  use 'majutsushi/tagbar'
  use 'merlinrebrovic/focus.vim'
  use 'mhinz/vim-grepper'
  use 'nelstrom/vim-textobj-rubyblock' -- A custom text object for selecting ruby blocks (ir, ar)
  use 'phb1/gtd.vim' -- Getting Things Done
  use 'reedes/vim-lexical'
  use 'reedes/vim-pencil'
  use 'rhysd/vim-github-actions'
  use 'rhysd/vim-grammarous'
  use 'robertbasic/vim-hugo-helper'
  use 'preservim/nerdcommenter'
  use 'shime/vim-livedown'
  use 'sjl/gundo.vim'
  use 'slim-template/vim-slim'
  use 'thoughtbot/pick.vim'
  use 'tpope/vim-abolish'
  use 'tpope/vim-bundler'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-ragtag'
  use 'tpope/vim-rails'
  use 'tpope/vim-rbenv'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rhubarb' -- Github support for Fugitive"
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use { 'vektorlab/slackcat', rtp = 'contrib/vim-slackcat' }
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  --use 'vim-scripts/Align'
  use 'vim-scripts/argtextobj.vim'
  use 'vim-scripts/bufexplorer.zip'
  use 'vim-scripts/dbext.vim'
  use 'vim-scripts/gnupg.vim'
  use 'vim-scripts/loremipsum'
  use 'vim-scripts/matchit.zip'
  use 'vimoutliner/vimoutliner'
  use { -- Enhanced multi file search
    'wincent/ferret',
    config = function()
      local opts = {
        noremap = true,
        silent = true,
      }
      -- vim.api.nvim_set_keymap('n', '<leader>fa', '<Plug>(FerretAck)', opts)
    end
  }
  use 'xolox/vim-misc'
  use 'xolox/vim-notes'

  -- UI Plugins
  use 'rhysd/nyaovim-popup-tooltip'

  use 'nyngwang/NeoZoom.lua'

  -- lsp {{{
  use { 'mfussenegger/nvim-dap' }
  use { 'mfussenegger/nvim-lint' }
  use { 'mhartington/formatter.nvim',
    config = function()
      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require("formatter").setup {
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          go = {
            require('formatter.filetypes.go').goimports
          },
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            require("formatter.filetypes.lua").stylua,
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace
          }
        }
      }
    end
  }
  use {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end,
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "golangci_lint_ls",
        }
      })
    end,
  }
  use { 'neovim/nvim-lspconfig', }
  use { 'nvim-lua/lsp-status.nvim' }
  -- }}}

  use { 'yuki-ycino/fzf-preview.vim', branch = 'release/rpc', run = ':UpdateRemotePlugins' }
  use 'ray-x/lsp_signature.nvim'

  -- indent-blankline {{{
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.termguicolors = true

      vim.api.nvim_exec(
        [[
          highlight IndentBlanklineChar         guifg=#555555 gui=nocombine
          highlight IndentBlanklineContextChar  guifg=#999999 gui=nocombine
          highlight IndentBlanklineContextStart guisp=#777777 gui=underline
        ]], false
      )

      require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = true,
        show_current_context_start_on_current_line = false,
        space_char_blankline = " ",
        use_treesitter = true,
      }
    end
  }
  -- }}}

  -- nvim-notify {{{
  use {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')
      vim.notify = notify

      print = function(...)
        local print_safe_args = {}
        local _ = { ... }
        for i = 1, #_ do
          table.insert(print_safe_args, tostring(_[i]))
        end
        notify(table.concat(print_safe_args, ' '), "info")
      end
      notify.setup({})

      vim.keymap.set('', '<Esc>', "<ESC>:noh<CR>:silent lua require('notify').dismiss()<CR>", { silent = true })
    end
  }
  -- }}}

  -- windows {{{
  use {
    'anuvyklack/windows.nvim',
    config = function()
      require 'windows'.setup {
        autowidth = {
          enable = true,
        },
        animation = {
          enable = true,
          duration = 100,
          fps = 30,
          easing = "in_out_sine",
        },
      }
    end,
    requires = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim'
    },
  }
  -- }}}

  -- nvim-cmp {{{
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-calc'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-emoji'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'ray-x/cmp-treesitter'

  use {
    'petertriho/cmp-git',
    config = function()
      require("cmp_git").setup()
    end,
  }

  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
      vim.cmd([[
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
        " -1 for jumping backwards.
        inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

        snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
        snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
      ]])
    end
  }
  use "rafamadriz/friendly-snippets"
  use 'Shougo/neosnippet-snippets'
  use "saadparwaiz1/cmp_luasnip"

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require("cmp")
      local cmp_buffer = require("cmp_buffer")

      local function t(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'treesitter' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'emoji' },
          { name = 'calc' },
          { name = 'git' },
        }, {
          { name = 'buffer' },
        }),
        sorting = {
          comparators = {
            function(...) return cmp_buffer:compare_locality(...) end,
          }
        },
        mapping = {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
          ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item()),
          ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item()),

          -- Work with UltiSnips
          -- ["<Tab>"] = cmp.mapping({
          --   c = function()
          --     if cmp.visible() then
          --       cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          --     else
          --       cmp.complete()
          --     end
          --   end,
          --   i = function(fallback)
          --     if cmp.visible() then
          --       cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          --     elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          --       vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
          --     else
          --       fallback()
          --     end
          --   end,
          --   s = function(fallback)
          --     if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          --       vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
          --     else
          --       fallback()
          --     end
          --   end
          -- }),
          -- ["<S-Tab>"] = cmp.mapping({
          --   c = function()
          --     if cmp.visible() then
          --       cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          --     else
          --       cmp.complete()
          --     end
          --   end,
          --   i = function(fallback)
          --     if cmp.visible() then
          --       cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          --     elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          --       return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), 'm', true)
          --     else
          --       fallback()
          --     end
          --   end,
          --   s = function(fallback)
          --     if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          --       return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), 'm', true)
          --     else
          --       fallback()
          --     end
          --   end
          -- }),
        },
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  }
  -- }}}

  -- " Telescope dependencies
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'kyazdani42/nvim-web-devicons'

  -- " Telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- {{{ telescope
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      local tt = require('telescope')
      tt.load_extension('fzf')
      tt.load_extension('file_browser')
      tt.load_extension('notify')
    end,
  }
  -- }}}

  -- theme
  use 'jsit/vim-tomorrow-theme'
  use {'arcticicestudio/nord-vim',
    config = function ()
      vim.api.nvim_exec([[
        colorscheme nord
      ]], false)
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
