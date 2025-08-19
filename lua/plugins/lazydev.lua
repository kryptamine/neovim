return {
  -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
      },
    },
  },
}
