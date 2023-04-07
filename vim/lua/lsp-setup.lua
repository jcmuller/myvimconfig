-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  "bashls",
  "ccls",
  "clangd",
  "golangci_lint_ls",
  "graphql",
  "jsonnet_ls",
  "regols",
  "sorbet",
  "sourcekit",
  "terraform_lsp",
  "terraformls",
  "tflint",
  "tsserver",
  "vala_ls",
  "yamlls",
}

local nvim_lsp = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local configs = require("lspconfig.configs")
local lsp_signature = require("lsp_signature")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
--

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('tagfunc', 'v:lua.vim.lsp.tagfunc')
  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr')

  -- Mappings.
  local opts = {
    noremap = true,
    silent = true,
  }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>lk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('i', '<c-space>', '<cmd>lua vim.lsp.omnifunc()<CR>', opts)
  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('i', '<C-A>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('x', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>le', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lQ', '<cmd>lua vim.diagnostic.setloclist({workspace=true})<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.show()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.get()<CR>', opts)
  buf_set_keymap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references({includeDeclaration = false})<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format({async=true})<CR>', opts)

  if client.server_capabilities.documentHighlightProvider then
    vim.opt.updatetime = 400

    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorHoldI", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })

    vim.api.nvim_set_hl(0, "LspReferenceText", {
      fg = "#f0c674",
      bold = true,
      -- ctermfg = 73,
      -- ctermbg = "red",
      -- cterm = { bold = true },
    })
    vim.api.nvim_set_hl(0, "LspReferenceRead", {
      fg = "#de935f",
      bold = true,
      -- ctermfg = 53,
      -- ctermbg = "red",
      -- cterm = { bold = true },
    })
    vim.api.nvim_set_hl(0, "LspReferenceWrite", {
      fg = "#cc6666",
      bold = true,
      -- ctermfg = 53,
      -- ctermbg = "red",
      -- cterm = { bold = true },
    })
  end

  lsp_signature.on_attach({
    hint_prefix = "",
    floating_window = false, -- only show arguments
    toggle_key = '<C-s>',
  }, bufnr)
end

if not configs.regols then
  configs.regols = {
    default_config = {
      cmd = { 'regols' };
      filetypes = { 'rego' };
      root_dir = require("lspconfig.util").root_pattern(".git");
    }
  }
end

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach
  }
end

nvim_lsp.solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    solargraph = {
      autoformat = true,
      -- bundlerPath = "bundle",
      -- checkGemVersion = true,
      -- commandPath = "solargraph",
      -- completion = true,
      -- definitions = true,
      diagnostics = true,
      -- folding = true,
      formatting = true,
      -- hover = true,
      -- logLevel = "warn",
      -- references = true,
      -- rename = true,
      -- symbols = true,
      -- transport = "socket",
      -- useBundler = false,
    },
  },
}

nvim_lsp.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      staticcheck = true,
      analyses = {
        fieldalignment = true,
        unusedparams = true,
        unusedwrite = true,
        nilness = true,
        shadow = true,
      },
    },
  },
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.lua_ls.setup {
  on_attach = on_attach,

  capabilities = capabilities,
  ft = "lua",
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
        -- library = vim.api.nvim_get_runtime_file("", true),
        maxPreload = 500,
        preloadFileSize = 1000,
      },
      diagnostics = {
        globals = { 'vim' },
      }
    }
  }
}

nvim_lsp.efm.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = { documentFormatting = true },
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
    -- "sh",
    "vim",
    -- "yaml"
  }
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

-- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async=true})' ]])
