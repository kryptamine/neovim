return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.pairs').setup()

      local map_bs = function(lhs, rhs)
        vim.keymap.set('i', lhs, rhs, { expr = true, replace_keycodes = false })
      end

      map_bs('<C-h>', 'v:lua.MiniPairs.bs()')
    end,
  },
}
