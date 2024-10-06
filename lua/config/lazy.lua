-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"stevearc/conform.nvim",
			opts = {},
		},
		{
			"williamboman/mason.nvim",
		},
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{
			"chomosuke/typst-preview.nvim",
			lazy = false, -- or ft = 'typst'
			version = "0.3.*",
			build = function()
				require("typst-preview").update()
			end,
		},
		{
			"andrewferrier/wrapping.nvim",
			config = function()
				require("wrapping").setup()
			end,
		},
		{
			"chrisgrieser/nvim-lsp-endhints",
			event = "LspAttach",
			opts = {}, -- required, even if empty
		},
		{
			"numToStr/Comment.nvim",
		},
		{
			"neoclide/coc.nvim",
			branch = "release",
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
				-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
			},
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = {},
	-- automatically check for plugin updates
	checker = { enabled = true },
})
