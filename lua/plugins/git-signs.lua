local icons = require 'config.icons'

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = {
          text = icons.ui.BoldLineLeft,
        },
        change = {
          text = icons.ui.BoldLineLeft,
        },
        delete = {
          text = icons.ui.TriangleShortArrowRight,
        },
        topdelete = {
          text = icons.ui.TriangleShortArrowRight,
        },
        changedelete = {
          text = icons.ui.BoldLineLeft,
        },
        untracked = {
          text = icons.ui.BoldLineLeft,
        },
      },
      signs_staged = {
        add = {
          text = icons.ui.BoldLineLeft,
        },
        change = {
          text = icons.ui.BoldLineLeft,
        },
        delete = {
          text = icons.ui.TriangleShortArrowRight,
        },
        topdelete = {
          text = icons.ui.TriangleShortArrowRight,
        },
        changedelete = {
          text = icons.ui.BoldLineLeft,
        },
        untracked = {
          text = icons.ui.BoldLineLeft,
        },
      },
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk Inline")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
      end,
    },
  },
}
