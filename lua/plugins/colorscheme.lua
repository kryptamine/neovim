return {
  -- {
  --   'mcauley-penney/techbase.nvim',
  --   opts = {
  --     italic_comments = true,
  --   },
  --   init = function()
  --     vim.cmd.colorscheme 'techbase'
  --   end,
  --   priority = 1000,
  -- },
  {
    'darianmorat/gruvdark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvdark'
    end,
  },
}
