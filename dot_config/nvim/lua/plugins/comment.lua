return {
	"numToStr/Comment.nvim", --  Commenting plugin
  config = function()
    require("Comment").setup({
      opleader = {
        line = "gc",
        block = "gb",
      },
      mappings = {
        basic = true,
      },
    })
  end,
}

