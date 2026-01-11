return {
  {
    'esmuellert/vscode-diff.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('codediff').setup {
        keymaps = {
          view = {
            next_file = ']f',
            prev_file = '[f',
          },
          explorer = {
            select = '<CR>',
            hover = 'K',
            refresh = 'R',
          },
        },
      }
    end,
  },
}
