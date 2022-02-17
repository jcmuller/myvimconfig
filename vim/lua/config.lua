-- lsp {{{
local nvim_lsp = require('lspconfig')
local lsp_signature = require("lsp_signature")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
local servers = {
  "solargraph",
  "terraform_lsp",
  "terraformls",
  "tflint",
  "tsserver",
}

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

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
  cmd = { "/opt/lua-language-server/bin/lua-language-server" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path
      },
      telemetry = {
        enable = false
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      diagnostics = {
        globals = {'vim'},
      }
    }
  }
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
-- nvim-cmp {{{
local cmp = require'cmp'
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    --["<Tab>"] = cmp.mapping(
    --   function(fallback)
    --     cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    --   end,
    --   { "i", "s", "c" }
    -- ),
    -- ["<S-Tab>"] = cmp.mapping(
    --   function(fallback)
    --     cmp_ultisnips_mappings.jump_backwards(fallback)
    --   end,
    --   { "i", "s", "c" }
    -- ),

    -- Work with UltiSnips
    ["<Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end
    }),
    ["<S-Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end
    }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'treesitter' },
    { name = 'emoji' },
    { name = 'calc' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
-- }}}
-- tabout {{{
require('tabout').setup {
  tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
  backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
  act_as_tab = true, -- shift content if tab out is not possible
  act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
  enable_backwards = true, -- well ...
  -- completion = true, -- if the tabkey is used in a completion pum
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
-- vim:foldmethod=marker
