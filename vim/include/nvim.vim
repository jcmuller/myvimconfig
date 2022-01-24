set directory=.           " Where to put swap files in
set shada='10,\"100,:20,%,n~/.vim/var/shada
set termguicolors         " Understand gui color configuration
set nottimeout            " No terminal UI timeouts (ESC works right away)
tnoremap <Esc> <C-\><C-n> " Use ESC in terminal to go to normal mode

let g:python3_host_prog = "~/.asdf/installs/python/3.8.6/bin/python3"
let g:python_host_prog  = "~/.asdf/installs/python/2.7.18/bin/python"
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

au TextYankPost * silent! lua vim.highlight.on_yank {timeout=250}

" compe {{{
set completeopt=menu,menuone,preview,noselect,noinsert
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
" }}}
lua << EOF
--- lsp {{{
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>lf',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>lk',  '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<c-space>',   '<cmd>lua vim.lsp.buf.omnifunc()<CR>', opts)
  buf_set_keymap('n', '<leader>ld',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>la',  '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>le',  '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>lq',  '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lr',  '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'K',           '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[d',          '<cmd>lua vim.diagnostic.show()<CR>', opts)
  buf_set_keymap('n', ']d',          '<cmd>lua vim.diagnostic.show()<CR>', opts)
  buf_set_keymap('n', '<leader>gD',          '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>gd',          '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gi',          '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>gr',          '<cmd>lua vim.lsp.buf.references({includeDeclaration = false})<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'solargraph', 'terraformls', 'terraform_lsp', 'tflint' }

for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup { on_attach = on_attach }
end

nvim_lsp.gopls.setup {
	on_attach = on_attach,
	cmd = {"gopls", "serve"},
	settings = {
		gopls = {
			analyses = {
				fieldalignment = true,
				unusedparams = true,
				unusedwrite = true,
				nilness = true,
			},
			staticcheck = true,
		},
	},
}

nvim_lsp.efm.setup {
	on_attach = on_attach,
	init_options = { documentFormatting = true },
	command = "efm-langserver",
	filetypes = {
		"css",
		"csv",
		"dockerfile",
		"eruby",
		"html",
		"javascript",
		"json",
		"make",
		"markdown",
		-- "terraform",
		-- "ruby",
		"python",
		"rst",
		"sh",
		"vim",
		--"yaml"
	}
}

nvim_lsp.yamlls.setup {
	on_attach = on_attach,
	settings = {
		yaml = {
			schemas = { kubernetes = "/*.yaml" },
		},
	},
}

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
	treesitter = true;
    buffer = true;
    path = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    --vsnip = true;
    ultisnips = true;
	emoji = true;
	-- tags = true;
	-- spell = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

-- vim.api.nvim_set_keymap("i", "<c-space>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local lsp_configs = require "lspconfig/configs"
local lsp_utils = require "lspconfig/util"
-- }}}

-- {{{ tree-sitter
require'nvim-treesitter.configs'.setup {
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
  }
}

-- }}}

-- {{{ telescope
local tt = require('telescope')
tt.load_extension('fzf')
tt.load_extension('file_browser')
-- }}}
EOF

" {{{ telescope

nnoremap <leader>tfB <cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>
nnoremap <leader>tfb <cmd>lua require('telescope').extensions.file_browser.file_browser({path = require('telescope.utils').buffer_dir()})<cr>
nnoremap <leader>tff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>tfF <cmd>lua require('telescope.builtin').find_files({cwd = require 'telescope.utils'.buffer_dir()})<cr>
nnoremap <leader>tlg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>tgr <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>tb  <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>th  <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>to  <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>tq  <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <leader>tT  <cmd>lua require('telescope.builtin').tags()<cr>
nnoremap <leader>tt  <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap <leader>tFF <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>

nnoremap <leader>tlr <cmd>lua require('telescope.builtin').lsp_references({includeDeclaration=false})<cr>
nnoremap <leader>tla <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>tlA <cmd>lua require('telescope.builtin').lsp_range_code_actions()<cr>
nnoremap <leader>tld <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>tlt <cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>
nnoremap <leader>tli <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <leader>tls <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>tlw <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
nnoremap <leader>tlW <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>

nnoremap <leader>tgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>tgf <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>tgB <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>tgb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>tgs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>tgS <cmd>lua require('telescope.builtin').git_stash()<cr>
" }}}

" {{{ tree-sitter
"set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" }}}

" Document Highlight {{{
augroup documenthighlight 
	autocmd!
	autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
	autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
	autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()

	highlight LspReferenceText guifg=#f0c674 ctermfg=73
	highlight LspReferenceRead guifg=#de935f ctermfg=53
	highlight LspReferenceWrite guifg=#cc6666 ctermfg=53
augroup END

augroup types_that_dont_support_highlight
	autocmd!
	autocmd FileType yaml setlocal eventignore=CursorHold,CursorHoldI,CursorMoved
augroup END
"}}}

" {{{ neo-tree
lua << EOF
require("neo-tree").setup({
  -- The default_source is the one used when calling require('neo-tree').show()
  -- without a source argument.
  default_source = "filesystem",
  popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid"
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_in_last_window = true,
  -- "NC" is a special style that works well with NormalNC set
  filesystem = {
    window = {
      -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
      -- for possible options. These can also be functions that return these
      -- options.
      position = "float", -- left, right, float
      width = 40, -- applies to left and right positions
      -- settings that apply to float position only
      popop = {
        size = {
          height = "80%",
          width = "50%"
        },
        position = "50%" -- 50% means center it
        -- you can also specify border here, if you want a different setting from
        -- the global popup_border_style.
      },
      -- Mappings for tree window. See |Neo-tree-Mappings| for built-in 
      -- commands. You can also create your own commands by providing a 
      -- function instead of a string. See the built-in commands for examples.
      mappings = {
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["<bs>"] = "navigate_up",
        ["u"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["I"] = "toggle_gitignore",
        ["R"] = "refresh",
        ["/"] = "filter_as_you_type",
        ["f"] = "filter_on_submit",
        ["<C-x>"] = "clear_filter",
        ["a"] = "add",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
      }
    },
    search_limit = 50, -- max number of search results when using filters
    filters = {
      show_hidden = true,
      respect_gitignore = true,
    },
    bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
    before_render = function(state)
      -- This function is called after the file system has been scanned,
      -- but before the tree is rendered. You can use this to gather extra
      -- data that can be used in the renderers.
      local utils = require("neo-tree.utils")
      state.git_status_lookup = utils.get_git_status()
    end,
    -- The components section provides custom functions that may be called by 
    -- the renderers below. Each componment is a function that takes the
    -- following arguments:
    --      config: A table containing the configuration provided by the user
    --              when declaring this component in their renderer config.
    --      node:   A NuiNode object for the currently focused node.
    --      state:  The current state of the source providing the items.
    --
    -- The function should return either a table, or a list of tables, each of which
    -- contains the following keys:
    --    text:      The text to display for this item.
    --    highlight: The highlight group to apply to this text.
    components = {
      hello_node = function (config, node, state)
        local text = "Hello " .. node.name
        if state.search_term then
          text = string.format("Hello '%s' in %s", state.search_term, node.name)
        end
        return {
          text = text,
          highlight = config.highlight or highlights.FILE_NAME,
        }
      end
    },
    -- This section provides the renderers that will be used to render the tree.
    -- The first level is the node type.
    -- For each node type, you can specify a list of components to render.
    -- Components are rendered in the order they are specified.
    -- The first field in each component is the name of the function to call.
    -- The rest of the fields are passed to the function as the "config" argument.
    renderers = {
      directory = {
        {
          "icon",
          folder_closed = "",
          folder_open = "",
          padding = " ",
        },
        { "current_filter" },
        { "name" },
        {
          "clipboard",
          highlight = "NeoTreeDimText"
        },
        { "diagnostics", errors_only = true },
        --{ "git_status" },
      },
      file = {
        {
          "icon",
          default = "-",
          padding = " ",
        },
        --{ "hello_node", highlight = "Normal" }, -- For example, don't actually
        -- use this!
        { "name" },
        {
          "clipboard",
          highlight = "NeoTreeDimText"
        },
        { "diagnostics" },
        {
          "git_status",
          highlight = "NeoTreeDimText"
        }
      },
    }
  },
})

vim.fn.sign_define("LspDiagnosticsSignError", {text = " ", texthl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = " ", texthl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = " ", texthl = "LspDiagnosticsSignInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", texthl = "LspDiagnosticsSignHint"})
EOF

nnoremap <space><space> :NeoTreeFocusToggle<CR>
nnoremap <space>f :NeoTreeReveal<CR>

augroup neotree
	autocmd!
	autocmd BufRead,BufNewFile neo-tree setlocal nospell
augroup END
" }}}

" Neovide {{{
let g:neovide_cursor_antialiasing=v:true
let g:neovide_cursor_animation_length=0
set guifont=Iosevka\ Term\ Light:h12
" }}}

" indent-blankline {{{ 
lua << EOF
require('indent_blankline').setup {
	show_current_context = true,
	show_current_context_start = true,
	show_current_context_start_on_current_line = false,
	space_char_blankline = " ",
	use_treesitter = true,
}
EOF

highlight IndentBlanklineChar         guifg=#555555 gui=nocombine
highlight IndentBlanklineContextChar  guifg=#999999 gui=nocombine
highlight IndentBlanklineContextStart guisp=#777777 gui=underline
" }}}
EOF
" }}}

" vim:tw=0:ts=4:sw=4:noet:nolist:foldmethod=marker
