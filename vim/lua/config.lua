--
require('plugins')
require('lsp-setup')
--
-- -- neorg {{{
-- require('neorg').setup {
--   load = {
--     ["core.norg.dirman"] = {
--       config = {
--         workspaces = {
--           work = "~/Nextcloud/Notes/Work",
--           home = "~/Nextcloud/Notes/Home",
--           gtd = "~/Nextcloud/gtd",
--         },
--       },
--     },
--
--     ["core.defaults"] = {},
--     ["core.export"] = {},
--     ["core.export.markdown"] = {},
--     ["core.gtd.base"] = { config = { workspace = "gtd", }, },
--     ["core.integrations.nvim-cmp"] = {},
--     ["core.integrations.telescope"] = {},
--     ["core.norg.completion"] = { config = { engine = "nvim-cmp", }, },
--     ["core.norg.concealer"] = {},
--     ["core.norg.journal"] = {},
--     ["core.norg.manoeuvre"] = {},
--     ["core.norg.qol.toc"] = {},
--     ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
--     ["external.context"] = {},
--     ["external.gtd-project-tags"] = {},
--     ["external.kanban"] = {},
--   }
-- }
-- -- }}}

vim.diagnostic.config({
  virtual_text = true,
})

-- vim:foldmethod=marker
