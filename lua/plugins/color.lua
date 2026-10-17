local function enable_transparency()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

return {
	{
		"folke/tokyonight.nvim",
		config = function()
			--   vim.cmd.colorscheme "tokyonight"
			--    enable_transparency()
		end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- 最高優先級，確保在啟動時最先載入顏色，避免畫面閃爍
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",  -- 可選風格: latte (亮色), frappe, macchiato, mocha (最受歡迎的暗色)
				transparent_background = false, -- 是否啟用背景透明
				integrations = {
					treesitter = true,
					neotree = true, -- 自動適配 Neo-tree 顏色
					telescope = { enabled = true },
					mason = true,
					which_key = true,
				},
				custom_highlights = function(colors)
					return {
						-- 游標當前行行號顯示黃色
						CursorLineNr = { fg = colors.yellow, bold = true },

						-- 浮動視窗邊框（含 lazygit.nvim 彈出框）全面套用黃色
						FloatBorder = { fg = colors.yellow },
						LazyGitBorder = { fg = colors.yellow },

						-- 搜尋關鍵字高亮強調
						Search = { bg = colors.yellow, fg = colors.base, bold = true },
						IncSearch = { bg = colors.yellow, fg = colors.base, bold = true },

						-- Neo-tree 目錄選取與圖示強調色
						NeoTreeCursorLine = { bg = colors.surface0 },
						NeoTreeDirectoryIcon = { fg = colors.yellow },
						NeoTreeDirectoryName = { fg = colors.text },
						SnacksDashboardHeader = { fg = colors.yellow, bold = true },
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
		},
		opts = {
			theme = "tokyonight",
		},
	},
}
