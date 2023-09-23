return {
  'f-person/git-blame.nvim',
  version = "*",
  lazy = true,

  config = function()
    require('git-blame').setup {}

  end,
}
