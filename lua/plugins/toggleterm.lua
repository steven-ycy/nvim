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

			vim.keymap.set("n", "<leader>fr", function()
				vim.cmd("write")
				local ft = vim.bo.filetype
				local cwd = vim.fn.getcwd()
				--local file = vim.fn.expand("%")
				local cmd = ""
				local file = vim.fn.expand("%:p") -- 原始檔完整路徑
				local fname = vim.fn.expand("%:t:r") -- 只有純檔名，不含副檔名與路徑 (例如 main.cpp -> main)
				local out_bin = cwd .. "/obj/" .. fname -- 目標二進位檔路徑

				local escaped_src = vim.fn.shellescape(file)
				local escaped_bin = vim.fn.shellescape(out_bin)

				-- 先建立 obj 目錄，再編譯，最後執行
				if ft == "cpp" then
					cmd = string.format("g++ -O2 %s -o %s && %s", escaped_src, escaped_bin, escaped_bin)
				elseif ft == "c" then
					cmd = string.format("gcc -O2 %s -o %s && %s", escaped_src, escaped_bin, escaped_bin)
				end

				-- 在 1 號浮動終端機中執行該指令
				require("toggleterm").exec(cmd, 1, nil, nil, "float")
			end, { desc = "Run current file in ToggleTerm" })
			vim.keymap.set("n", "<leader>fd", function()
				vim.cmd("write")
				local ft = vim.bo.filetype
				local cwd = vim.fn.getcwd()
				--local file = vim.fn.expand("%")
				local cmd = ""
				local file = vim.fn.expand("%:p") -- 原始檔完整路徑
				local fname = vim.fn.expand("%:t:r") -- 只有純檔名，不含副檔名與路徑 (例如 main.cpp -> main)
				local out_bin = cwd .. "/obj/" .. fname -- 目標二進位檔路徑

				local escaped_src = vim.fn.shellescape(file)
				local escaped_bin = vim.fn.shellescape(out_bin)

				-- 先建立 obj 目錄，再編譯，最後執行
				if ft == "cpp" then
					cmd = string.format("g++ -g -O0 %s -o %s", escaped_src, escaped_bin)
				elseif ft == "c" then
					cmd = string.format("gcc -g -O0 %s -o %s", escaped_src, escaped_bin)
				end

				-- 在 1 號浮動終端機中執行該指令
				require("toggleterm").exec(cmd, 1, nil, nil, "float")
			end, { desc = "ToggleTerm and for debugging" })
		end
	},

}
