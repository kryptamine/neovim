return {
  {
    'saghen/blink.cmp',
    lazy = false,
    version = 'v0.*',
    opts = {
      keymap = {
        ['<CR>'] = { 'select_and_accept', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
      },
      completion = {
        menu = {
          border = nil,
          scrolloff = 1,
          scrollbar = false,
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description' },
              { 'kind' },
            },
          },
        },
      },
    },
  },
}
