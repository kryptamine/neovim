return {
  {
    'darianmorat/gruvdark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvdark'
    end,
  },
}
