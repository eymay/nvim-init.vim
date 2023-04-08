""" Eymen's Neovim Init.vim

""" Vim-Plug
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'github/copilot.vim'
""" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-media-files.nvim'
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
""" Enhancement to writing
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.2.1.*', 'do': 'make install_jsregexp'}
Plug 'nvim-lualine/lualine.nvim' 
""" Themes
Plug 'marko-cerovac/material.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'folke/tokyonight.nvim'
""" LLVM
Plug 'rhysd/vim-llvm'
""" Debugger
Plug 'mfussenegger/nvim-dap'
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
--require('codelldb-config')
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

set nowrap
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nohlsearch
set hidden
set incsearch  
set scrolloff=6
set relativenumber
"""Terminal Mapping
tnoremap <leader><Esc> <C-\><C-n>
"""Theme
colorscheme kanagawa
"au BufWritePost *.td !ninja -C ~/Documents/Compiler/llvm15/build llc &

autocmd FileType llvm,tablegen nmap <buffer><silent>gK <Plug>(llvm-goto-definition)
autocmd BufRead *.png,*.pdf,*.dot !xdg-open %
autocmd BufRead *.mp4 !vlc %
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

" LuaSnip mappings
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
