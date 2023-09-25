return {
  'f-person/git-blame.nvim',
  version = "*",
  lazy = false,

  config = function()
    require('gitblame').setup {
      enabled = true,
      message_template = '<summary> • <date> • <author>',
      date_format = '%r',
      virtual_text_column = 80,
    }
  end,
}
