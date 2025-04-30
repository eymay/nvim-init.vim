return {
    {
	"rebelot/kanagawa.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
	    -- load the colorscheme here
	    vim.cmd([[colorscheme kanagawa]])
	end
    }, {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
	local configs = require("nvim-treesitter.configs")

	configs.setup({
	    ensure_installed = {"cpp", "lua", "vim", "html"},
	    sync_install = false,
	    highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	    },
	    indent = {enable = true}
	})

    end
}, 
	{'williamboman/mason.nvim', lazy = false, config = true},
    -- Source https://lsp-zero.netlify.app/v3.x/guide/lazy-loading-with-lazy-nvim
     {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
	    {'hrsh7th/cmp-path'},
        },
        config = function()
            local cmp = require('cmp')
            
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })
        end
    },
    {
	'numToStr/Comment.nvim',
	opts = {
	    -- add any options here
	},
	lazy = false
    }, {
	"lervag/vimtex", lazy = false,
	    init = function()
	    vim.g.vimtex_view_automatic = 0
	    end
    }, 
{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    , {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.6',
	-- or                              , branch = '0.1.x',
	dependencies = {'nvim-lua/plenary.nvim'},
	config = function() require("telescope").setup {
		pickers = {
		  find_files = {
		    find_command = {'rg', '--files', '--hidden', '--glob', '!.git/*'},
		    },
		},
	    } end
    }, {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {"nvim-tree/nvim-web-devicons"},
	config = function() require("nvim-tree").setup {
	    git = {
		enable = true,
		ignore = false,
		timeout = 500,
	    },
	} end
    }, {"tpope/vim-fugitive", lazy = false}
     , {"tpope/vim-surround", lazy = false}
}
