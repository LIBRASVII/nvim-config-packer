-- Install Packer automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()


-- Reload configurations if we modify plugins.lua
-- Hint
--     <afile> - replaced with the filename of the buffer being manipulated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Install plugins here - `use ...`
-- Packer.nvim hints
--     after = string or list,           -- Specifies plugins to load before this plugin. See "sequencing" below
--     config = string or function,      -- Specifies code to run after this plugin is loaded
--     requires = string or list,        -- Specifies plugin dependencies. See "dependencies". 
--     ft = string or list,              -- Specifies filetypes which load this plugin.
--     run = string, function, or table, -- Specify operations to be run after successful installs/updates of a plugin
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim'}
    -- use { 'neovim/nvim-lspconfig' }            -- previous installed

    -- CMP
    use { 'neovim/nvim-lspconfig' }
    use { 'hrsh7th/nvim-cmp', config = [[require('config.nvim-cmp')]] }    
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' } 
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }        -- buffer auto-completion
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }          -- path auto-completion
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }       -- cmdline auto-completion
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- file explorer
    use 'nvim-tree/nvim-tree.lua'

    -- vs-code like icons
    use 'nvim-tree/nvim-web-devicons'

    -- which-key
    use {
    "folke/which-key.nvim",
    config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
        }
      end
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  requires = {
    --- Uncomment these if you want to manage LSP servers from neovim
    -- {'williamboman/mason.nvim'},
    -- {'williamboman/mason-lspconfig.nvim'},

    -- LSP Support
    {'neovim/nvim-lspconfig'},
    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
  }
}

     -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

