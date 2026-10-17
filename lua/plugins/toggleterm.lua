return {

	-- amongst your other plugins
	{

		'akinsho/toggleterm.nvim',
		version = "*",
		dependencies = {
			"catppuccin/nvim", -- 確保 catppuccin 先就緒
		},
		config = function()
			local colors = require("catppuccin.palettes").get_palette("mocha")
			require("toggleterm").setup({
				float_opts = {
					border = "curved", -- 圓角邊框
					winblend = 0,
				},
				open_mapping = [[<c-\>]],
				direction = "float",
				shade_terminals = true,
				shading_ratio = -0.3,
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				highlights = {
					Normal = {
						guibg = colors.mantle, -- mantle 比主背景 (base) 稍微深一點點，凸顯層次感
					},
					NormalFloat = {
						link = "Normal",
					},
					FloatBorder = {
						guifg = colors.yellow, -- 改為黃色（Catppuccin Mocha Yellow: #f9e2af）
						guibg = colors.mantle, -- 邊框底色與視窗內部一致，乾淨無接縫
					},
				},
			})

			vim.keymap.set({ "n", "t" }, "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",
				{ desc = "Toggle Float Terminal" })


			vim.keymap.set({ "n", "t" }, "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",
				{ desc = "Toggle Vertical Terminal" })
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }

				vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
				vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
				vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
			end

			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "term://*toggleterm#*",
				callback = function()
					set_terminal_keymaps()
				end,
				desc = "Apply terminal keymaps to toggleterm",
			})

			vim.keymap.set("n", "<leader>r", function()
				vim.cmd("write")
				local ft = vim.bo.filetype
				local file = vim.fn.expand("%")
				local cmd = ""

				if ft == "cpp" then
					cmd = "g++ -O2 " .. file .. " -o /tmp/app && /tmp/app"
				elseif ft == "c" then
					cmd = "gcc -O2 " .. file .. " -o /tmp/app && /tmp/app"
				elseif ft == "python" then
					cmd = "python3 " .. file
				elseif ft == "sh" then
					cmd = "bash " .. file
				else
					vim.notify("未支援的檔案類型: " .. ft, vim.log.levels.WARN)
					return
				end

				-- 在 1 號浮動終端機中執行該指令
				require("toggleterm").exec(cmd, 1, nil, nil, "float")
			end, { desc = "Run current file in ToggleTerm" })
		end
	},

}
