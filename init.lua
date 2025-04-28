local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins")
vim.api.nvim_set_option("clipboard", "unnamed")

-- Configure diagnostics for Neovim 0.11
-- Virtual text is disabled by default in 0.11
vim.diagnostic.config({
    virtual_text = true,  -- Re-enable if you want virtual text diagnostics
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    float = {
        source = 'always',
    },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume last picker' })

require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', '<leader>b', ':NvimTreeFindFileToggle<CR>',
                        {noremap = true, silent = true})

vim.g.markdown_fenced_languages = {'mlir'}

-- New default LSP keymaps added in Neovim 0.11
-- Uncomment if you want to use them
-- vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
-- vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = 'Show references' })
-- vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, { desc = 'Show implementation' })
-- vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, { desc = 'Document symbols' })
-- vim.keymap.set({'n', 'v'}, 'gra', vim.lsp.buf.code_action, { desc = 'Code action' })
-- vim.keymap.set({'i', 's'}, '<C-s>', vim.lsp.buf.signature_help, { desc = 'Signature help' })
