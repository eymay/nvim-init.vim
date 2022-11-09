""" Eymen's Neovim Init.vim

""" Vim-Plug
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'github/copilot.vim'
""" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
""" File Explorer
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
""" Git Plugin
Plug 'tpope/vim-fugitive'
""" Default universal settings
Plug 'tpope/vim-sensible'
""" Surrounding character operations
Plug 'tpope/vim-surround'
"""
Plug 'nvim-lualine/lualine.nvim'
""" Themes
Plug 'marko-cerovac/material.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'folke/tokyonight.nvim'
call plug#end()

""" Core plugin configuration (lua)
lua << EOF
--servers = {
  --  'pyright',
    --'tsserver', -- uncomment for typescript. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for other language servers
--}
require('treesitter-config')
--require('nvim-cmp-config')
require('lspconfig-config')
require('telescope-config')
require('lualine-config')
require('material-config')
require('nvim-tree-config')
--require('diagnostics')
vim.g.material_style = "oceanic"
EOF

""" Space Bar as Leader Key
nnoremap <SPACE> <Nop>
let mapleader = " "
nmap <leader>s :so ~/.config/nvim/init.vim<CR>
nmap <leader>b :NvimTreeFindFileToggle<CR>
nmap <leader>j <C-w>v<C-w>l:terminal<CR>:set nonumber<CR><S-a>

"""Terminal Mapping
tnoremap <leader><Esc> <C-\><C-n>
"""Theme
colorscheme kanagawa


"Treesitter folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable        	
" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope colorscheme<cr>
nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
