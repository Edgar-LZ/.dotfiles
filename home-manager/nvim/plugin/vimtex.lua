vim.cmd("let g:vimtex_complete_enabled = 1")
vim.cmd("let g:tex_flavor = 'latex'")

vim.cmd("filetype plugin indent on")

vim.cmd("syntax enable")

vim.cmd("let g:vimtex_view_general_viewer = 'zathura'")

vim.keymap.set('n', '<leader>la', vim.cmd.VimtexCompile)


