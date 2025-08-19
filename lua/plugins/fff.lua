return {
  {
    'dmtrKovalenko/fff.nvim',
    build = 'cargo build --release',
    opts = {
      title = 'Find Files',
      prompt = '🔎 ',
      layout = {
        width = 0.5,
        height = 0.6,
      },
      preview = {
        enabled = false,
      },
    },
    keys = {
      {
        '<leader><space>',
        function()
          require('fff').find_files()
        end,
        desc = 'Open file picker',
      },
    },
  },
}
