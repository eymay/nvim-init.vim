-- LSP configuration for Neovim 0.11

local M = {}

-- Configure LSP servers
local function setup_servers()
    vim.lsp.config('clangd', {
        cmd = { "clangd" },
        filetypes = { 'c', 'cpp' },
    })

    -- Configure pyright (Python)
    vim.lsp.config('pyright', {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { 'python' },
    })

    -- Configure texlab (LaTeX)
    vim.lsp.config('texlab', {
        cmd = { "texlab" },
        filetypes = { 'tex', 'latex' },
        settings = {
            texlab = {
                build = {
                    onSave = true,
                },
            },
        },
    })

    vim.lsp.enable('clangd')
    vim.lsp.enable('pyright')
    vim.lsp.enable('texlab')
end

-- Set up keybindings when LSP attaches to a buffer
local function setup_keymaps()
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            local bufnr = ev.buf
            
            -- Print a message to confirm attachment (useful for debugging)
            print("LSP " .. client.name .. " attached to buffer " .. bufnr)
            
            -- Buffer-local mappings
            local opts = { buffer = bufnr }
            
            -- Navigation
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            
            -- Information
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
            
            -- Actions
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>f', function() 
                vim.lsp.buf.format { async = true } 
            end, opts)
            
            -- Diagnostics
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            
            -- Optional: Auto-formatting on save
            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    callback = function() 
                        vim.lsp.buf.format { async = false, bufnr = bufnr } 
                    end,
                })
            end
        end,
    })
end

-- Initialize everything
function M.setup()
    setup_servers()
    setup_keymaps()
end

-- Run setup immediately
M.setup()

return M
