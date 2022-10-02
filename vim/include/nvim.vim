set directory=.           " Where to put swap files in
set shada='10,\"100,:20,%,n~/.vim/var/shada
set termguicolors         " Understand gui color configuration
set nottimeout            " No terminal UI timeouts (ESC works right away)
tnoremap <Esc> <C-\><C-n> " Use ESC in terminal to go to normal mode

let g:python3_host_prog = "/usr/sbin/python"
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

au TextYankPost * silent! lua vim.highlight.on_yank {timeout=250}

lua require("config")

" nvim-cmp {{{
set completeopt=menu,menuone,noselect
" }}}
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
set foldexpr=nvim_treesitter#foldexpr()
" }}}
" Neovide {{{
let g:neovide_cursor_antialiasing=v:true
let g:neovide_cursor_animation_length=0
set guifont=Iosevka\ Term\ Light:h12
" }}}
" NeoZoom {{{
nnoremap <Leader>z :NeoZoomToggle<cr>
" }}}

" vim:tw=0:ts=4:sw=4:et:nolist:foldmethod=marker
