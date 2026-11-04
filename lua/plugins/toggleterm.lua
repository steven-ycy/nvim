return {

	-- amongst your other plugins
	{

		'akinsho/toggleterm.nvim',
		version = "*",
		dependencies = {
			"catppuccin/nvim",
		},
		config = function()
			local colors = require("catppuccin.palettes").get_palette("mocha")
			require("toggleterm").setup({
				float_opts = {
					border = "curved",
					winblend = 0,
					height = function() return math.floor(vim.o.lines * 0.5) end,
					row = function() return math.floor(vim.o.lines * 0.45) end,



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
					-- highlights which map to a highlight group name and a table of it's values
					-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
					Normal = {
						guibg = "none",
					},
					NormalFloat = {
						guibg = "none",

					},
					FloatBorder = {
						guifg = colors.yellow,
						guibg = "none",
					},
				},

			})
			local Terminal = require("toggleterm.terminal").Terminal
			local terms = {}
			local defnum = 1

			local function toggle_numbered_term(num)
				num = num or defnum

				if not terms[num] then
					terms[num] = Terminal:new({
						count = num,
						direction = "float",
						on_open = function(term)
							vim.api.nvim_win_set_config(term.window, {
								title = string.format("  Terminal #%d ", num),

								title_pos = "center",
							})
						end,
					})
				end

				terms[num]:toggle()
			end
			vim.keymap.set("n", "<leader>tc", function()
				local cwd = vim.fn.expand("%:p:h")
				require("toggleterm").exec("cd " .. vim.fn.fnameescape(cwd), 1)
			end, { desc = "CD terminal 1 to current file dir" })
			for i = 1, 5 do
				vim.keymap.set({ "n", "t" }, "<leader>t" .. i, function()
					require("toggleterm").toggle(i, nil, nil, "float")
				end, { desc = string.format("切換 %d 號浮動終端機", i) })
			end

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

				if ft == "cpp" then
					cmd = string.format(
						"g++ -g -O0 -fsanitize=address,undefined -fno-omit-frame-pointer -Wall -Wextra %s -o %s && %s",
						escaped_src, escaped_bin, escaped_bin)
				elseif ft == "c" then
					cmd = string.format(
						"gcc -g -O0 -fsanitize=address,undefined -fno-omit-frame-pointer -Wall -Wextra %s -o %s && %s",
						escaped_src, escaped_bin, escaped_bin)
				end
				require("toggleterm").exec(cmd, 3, nil, nil, "float")
			end, { desc = "Run current file in ToggleTerm" })
			for i = 1, 5 do
				vim.keymap.set("n", "<leader>f" .. i, function()
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

					if ft == "cpp" then
						cmd = string.format(
							"g++ -O2 -g -Wall -Wextra %s -o %s && %s",
							escaped_src, escaped_bin, escaped_bin)
					elseif ft == "c" then
						cmd = string.format(
							"gcc -O2 -std=c17 -g -Wall -Wextra %s -o %s && %s",
							escaped_src, escaped_bin, escaped_bin)
					end
					require("toggleterm").exec(cmd, i, nil, nil, "float")
				end, { desc = string.format("Run current file in ToggleTerm %d", i) })
			end
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

				if ft == "cpp" then
					cmd = string.format(
						"g++ -g -O0 -fsanitize=address -fno-sanitize-recover=all -fno-omit-frame-pointer %s -o %s",
						escaped_src,
						escaped_bin)
				elseif ft == "c" then
					cmd = string.format(
						"gcc -g -O0 -fsanitize=address -fno-sanitize-recover=all -fno-omit-frame-pointer %s -o %s",
						escaped_src,
						escaped_bin)
				end
				require("toggleterm").exec(cmd, 3, nil, nil, "float")
			end, { desc = "ToggleTerm and for debugging" })
		end
	},

}
