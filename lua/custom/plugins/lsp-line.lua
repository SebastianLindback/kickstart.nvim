return {
  'Maan2003/lsp_lines.nvim',
  version = "*",
  lazy = false,

  config = function()
    require('lsp_lines').setup {
    }
    vim.diagnostic.config({
      -- Disable virtual_text since it's redundant due to lsp_lines.
      virtual_text = false,
      -- virtual_lines = { only_current_line = true },
    })
    vim.keymap.set(
      "",
      "<Leader>l",
      require("lsp_lines").toggle,
      { desc = "Toggle lsp_lines" }
    )
  end,
}
