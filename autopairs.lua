return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		-- If you want insert `(` after select function or method item
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done()),
			disable_filetype = { "TelescopePrompt", "vim" },
		})
	end,
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
}
