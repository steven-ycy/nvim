local function enable_transparency()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

return {
	{
		"folke/tokyonight.nvim",
		config = function()
			--   vim.cmd.colorscheme "tokyonight"
			enable_transparency()
		end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- 最高優先級，確保在啟動時最先載入顏色，避免畫面閃爍
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- 可選風格: latte (亮色), frappe, macchiato, mocha (最受歡迎的暗色)
				transparent_background = true, -- 是否啟用背景透明
				integrations = {
					treesitter = true,
					neotree = true, -- 自動適配 Neo-tree 顏色
					telescope = { enabled = true },
					mason = true,
					which_key = true,
					noice = true,
					notify = true,
					cmp = true,

				},
				custom_highlights = function(colors)
					return {
						Normal       = { fg = "#1e1e2e", bg = "#f9f1a5" },
						CursorLineNr = { fg = colors.peach, bold = true },
						CursorLine   = { bg = "#040935", fg = "#ffffe5" },
						LineNr       = { fg = "#415a77", bg = "none" },
						Visual       = { bg = "#1b2438", fg = "none" },
						FloatBorder  = { fg = colors.lavender, bg = "#1e1e2e" },
						NormalFloat  = { bg = "#1e1e2e" },
						FloatTitle   = { bg = "none", fg = colors.maroon, bold = true },


						LazyGitBorder = { fg = colors.yellow, bold = true },
						LazyGitFloat = { bg = "none", fg = colors.rosewater },

						-- 搜尋關鍵字高亮強調
						Search = { bg = colors.yellow, fg = colors.base, bold = true },
						IncSearch = { bg = colors.yellow, fg = colors.base, bold = true },

						NeoTreeCursorLine = { link = "CursorLine" },
						NeoTreeDirectoryIcon = { fg = colors.yellow },
						NeoTreeDirectoryName = { fg = colors.text },
						SnacksDashboardHeader = { fg = colors.yellow, bold = true },
						NeoTreeNormal = { bg = "none" },
						NeoTreeNormalNC = { bg = "none" },
						NeoTreeEndOfBuffer = { bg = "none" },
						SnacksDashboardNormal = { bg = "none" },
						SnacksDashboardTerminal = { bg = "none" },
						NoiceArrowLavender = {
							fg = colors.lavender,
							bold = true,
						},
						NoiceBracketBlue = {
							fg = colors.blue,
							bold = true,
						},


						NoiceStart = {
							fg = "#E6C384",
						}


						--SnacksDashboardNormalNC = { bg = "none" },
						--NeoTreeSignColumn       = { bg = "none" }
					}
				end,
			})

			-- 將 Neovim 的色彩主題正式套用為 catppuccin
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"catppuccin/nvim",

		},
		opts = function()
			return {
				options    = {
					theme = 'everforest',
				},
				extensions = { 'toggleterm', 'quickfix' }
			}
		end
	},
}
