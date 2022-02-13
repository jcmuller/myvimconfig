--- lsp {{{
local nvim_lsp = require('lspconfig')
local lsp_signature = require("lsp_signature")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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
  buf_set_keymap('n', '<leader>gD',  '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>gd',  '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>gr',  '<cmd>lua vim.lsp.buf.references({includeDeclaration = false})<CR>', opts)

  if client.resolved_capabilities.document_formatting then 
    buf_set_keymap('n', '<leader>lf',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      highlight LspReferenceText guifg=#f0c674 ctermfg=73
      highlight LspReferenceRead guifg=#de935f ctermfg=53
      highlight LspReferenceWrite guifg=#cc6666 ctermfg=53

      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  lsp_signature.on_attach({
    hint_prefix = "",
    floating_window = false, -- only show arguments
    toggle_key = '<C-s>',
  }, bufnr)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph", "terraformls", "terraform_lsp", "tflint", "tsserver" }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach
  }
end

nvim_lsp.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        fieldalignment = true,
        unusedparams = true,
        unusedwrite = true,
        nilness = true,
        shadow = true,
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
    -- "javascript",
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

nvim_lsp.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemas = { kubernetes = "/*.yaml" },
    },
  },
}

--   -- diagnosticls
--   local filetypes = {
--       typescript = "eslint",
--       typescriptreact = "eslint",
--   }
--
--   local linters = {
--       eslint = {
--           sourceName = "eslint",
--           command = "eslint_d",
--           rootPatterns = {".eslintrc.js", "package.json"},
--           debounce = 100,
--           args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
--           parseJson = {
--               errorsRoot = "[0].messages",
--               line = "line",
--               column = "column",
--               endLine = "endLine",
--               endColumn = "endColumn",
--               message = "${message} [${ruleId}]",
--               security = "severity"
--           },
--           securities = {[2] = "error", [1] = "warning"}
--       }
--   }
--   local formatters = {
--       prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
--   }
--   local formatFiletypes = {
--       typescript = "prettier",
--       typescriptreact = "prettier"
--   }
--   nvim_lsp.diagnosticls.setup {
--       on_attach = on_attach,
--       filetypes = vim.tbl_keys(filetypes),
--       init_options = {
--           filetypes = filetypes,
--           linters = linters,
--           formatters = formatters,
--           formatFiletypes = formatFiletypes
--       }
--   }

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

require('compe').setup {
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
-- tabout {{{
require('tabout').setup {
  tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
  backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
  act_as_tab = true, -- shift content if tab out is not possible
  act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
  enable_backwards = true, -- well ...
  completion = true, -- if the tabkey is used in a completion pum
  tabouts = {
    {open = "'", close = "'"},
    {open = '"', close = '"'},
    {open = '`', close = '`'},
    {open = '(', close = ')'},
    {open = '[', close = ']'},
    {open = '{', close = '}'}
  },
  ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
  exclude = {} -- tabout will ignore these filetypes
}
-- }}}
-- vim:foldmethod=marker
