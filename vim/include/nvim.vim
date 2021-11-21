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
  buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap('n', '<leader>lk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<c-space>', '<Cmd>lua vim.lsp.buf.omnifunc()<CR>', opts)
  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>le', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph", "terraformls", "terraform_lsp", "tflint" }

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
		"yaml"
	}
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
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    --vsnip = true;
    ultisnips = true;
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
  },
  indent = {
    enable = true
  }
}

-- }}}

-- {{{ telescope
require('telescope').load_extension('fzf')
-- }}}
EOF

" {{{ telescope
nnoremap <space><space> <cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>
nnoremap <space>f <cmd>lua require('telescope').extensions.file_browser.file_browser({cwd = require('telescope.utils').buffer_dir()})<cr>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').tags()<cr>

nnoremap <leader>flr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>fla <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>fld <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>flt <cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>
nnoremap <leader>fli <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <leader>fls <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>flw <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
nnoremap <leader>flW <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>

nnoremap <leader>fGc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fGB <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>fGb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>fGs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>fGS <cmd>lua require('telescope.builtin').git_stash()<cr>
" }}}
"
" {{{ tree-sitter
"set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" }}}

" vim:tw=0:ts=4:sw=4:noet:nolist:foldmethod=marker
