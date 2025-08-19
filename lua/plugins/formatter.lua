local function first(bufnr, ...)
  local conform = require 'conform'
  for i = 1, select('#', ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

local prettier_langs = {
  'javascript',
  'typescript',
  'javascriptreact',
  'typescriptreact',
  'css',
  'html',
  'json',
  'yaml',
  'markdown',
}

local options = {
  format_on_save = {
    lsp_format = 'fallback',
    timeout_ms = 5000,
  },

  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    c = { 'clang-format' },
    go = { 'gofmt' },
  },

  default_format_opts = {
    lsp_format = 'fallback',
  },

  formatters = {},
}

for _, lang in ipairs(prettier_langs) do
  options.formatters_by_ft[lang] = { 'prettier' }
end

-- Override JS/TS to prefer eslint if available
options.formatters_by_ft.javascript = function(bufnr)
  return { first(bufnr, 'prettierd', 'prettier'), first(bufnr, 'eslint_d', 'eslint') }
end

options.formatters_by_ft.typescript = function(bufnr)
  return { first(bufnr, 'prettierd', 'prettier'), first(bufnr, 'eslint_d', 'eslint') }
end

return {
  'stevearc/conform.nvim',
  opts = options,
}
