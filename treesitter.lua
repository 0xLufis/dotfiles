local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"
local function have(path)
	return vim.uv.fs_stat(xdg_config .. "/" .. path) ~= nil
end

--Opts
local opts = function(_, opts)
	local function add(lang)
		if type(opts.ensure_installed) == "table" then
			table.insert(opts.ensure_installed, lang)
		end
	end

	vim.filetype.add({
		extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
		filename = {
			["vifmrc"] = "vim",
		},
		pattern = {
			[".*/waybar/config"] = "jsonc",
			[".*/mako/config"] = "dosini",
			[".*/kitty/.+%.conf"] = "bash",
			[".*/hypr/.+%.conf"] = "hyprlang",
			["%.env%.[%w_.-]+"] = "sh",
		},
	})

	add("git_config")

	if have("hypr") then
		add("hyprlang")
	end

	if have("fish") then
		add("fish")
	end

	if have("rofi") or have("wofi") then
		add("rasi")
	end
end

return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	lazy = false,
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		local config = treesitter.setup({
			-- A list of parser names, or "all" (the listed parsers MUST always be installed)
			highlight = {
				enable = true,

				-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
				-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
				-- the name of the parser)
				-- list of language that will be disabled
				-- disable = { "c", "rust" },
				-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
				--	disable = function(lang, buf)
				--		local max_filesize = 100 * 1024 -- 100 KB
				--		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				--		if ok and stats and stats.size > max_filesize then
				--			return true
				--		end
				--	end,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			ensure_installed = {
				"c_sharp",
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"java",
				"javascript",
			},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			-- List of parsers to ignore installing (or "all")
			ignore_install = { "javascript" },

			---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
			-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
		})
	end,
	opts = opts,
}

--Config
