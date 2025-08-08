-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  desc = 'Close buffers when files are deleted in Oil',
  pattern = 'OilActionsPost',
  callback = function(args)
    if args.data.err then
      return
    end
    for _, action in ipairs(args.data.actions) do
      if action.type == 'delete' then
        local _, path = require('oil.util').parse_url(action.url)
        local bufnr = vim.fn.bufnr(path)

        if bufnr ~= -1 then
          Snacks.bufdelete.delete {
            buf = bufnr,
          }
          vim.cmd.bwipeout { bufnr, bang = true }
        end
      end
    end
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('checktime', { clear = true }),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd('BufEnter', { command = [[set formatoptions-=cro]] })

-- close some filetypes with <esc>
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close_with_esc', { clear = true }),
  pattern = {
    'oil',
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'startuptime',
    'checkhealth',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'notify',
    'qf',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', '<esc>', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})
