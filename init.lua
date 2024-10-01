vim.g.mapleader = " "
vim.g.localleader = " "

--Lazy & plugins 
require("config.lazy")

--Personal config
require("config.options")
require("config.keymap")
require("config.autocmds")
