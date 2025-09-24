return {
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
    event = { 'User KittyScrollbackLaunch' },
    config = function()
      vim.keymap.set({ 'n', 'i' }, '<C-m>', '<Plug>(KsbExecuteCmd)', {})
      require('kitty-scrollback').setup()
    end,
  },
}
