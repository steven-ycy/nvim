-- lazy.nvim
return {
	"folke/noice.nvim",
	event        = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		"hrsh7th/nvim-cmp",

		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	config       = function()
		local colors = require("catppuccin.palettes").get_palette("mocha")

		local colors2 = require("catppuccin.palettes").get_palette("frappe")
		vim.api.nvim_set_hl(0, "MyLavenderBorder", { fg = colors2.lavender })
		vim.keymap.set("n", "<leader>nn", "<cmd>Noice<cr>", { desc = "Search Messages (Noice)" })
		vim.keymap.set("n", "<leader>na", "<cmd>Noice all<cr>", { desc = "Search Messages all(Noice)" })
		require("noice").setup({
			cmdline = {
				format = {
					cmdline = { icon = "\u{f0f67}" }
				}
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			commands = {

				history = {
					-- options for the message history that you get with `:Noice`
					view = "custom_popup",
					opts = { enter = true, format = "details" },
					filter = {
						any = {
							{ event = "notify" },
							{ error = true },
							{ warning = true },
							{ event = "msg_show" },
							{ event = "lsp",     kind = "message" },
						},
					},
				},
				all = {
					-- options for the message history that you get with `:Noice`
					view = "custom_popup",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			},
			views = {
				hover = {
					border = {
						style = "rounded",
						padding = { 0, 1 }, -- 上下 0 行、左右 1 格內距
					},
					size = {
						max_width = 80, -- 最大寬度上限（防止過寬）


						max_height = 20, -- 最大高度上限（超出時會出現捲動）
					},
					position = { row = 2, col = 1 },
					win_options = {
						winhighlight = {
							Normal = "NormalFloat",
							FloatBorder = "FloatBorder",
						},
					},
				},
				custom_popup = {
					backend = "popup",
					enter = true,
					border = {
						style = "rounded", padding = { 0, 1 },
					},
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = "65%",
						height = "60%",
					},
					close = {
						keys = { "q", "<Esc>" }, },
					win_options = {
						winblend = 90,
						winhighlight = {
							Normal = "NoicePopupNormal",
							FloatBorder = "NoicePopupBorder",
						},
						wrap = true,
					},
				},
			},
			format = {
				-- default = {
				-- 	{ "{level} " },
				-- 	{
				-- 		"{title}",
				-- 		before = { "[ ", hl_group = "Comment" },
				-- 		after = { " ] ", hl_group = "Comment" }
				-- 	},
				--
				-- 	{ "{message}", before = { "\n \u{276f} ", hl_group = "NoiceArrowYellow" } },
				-- },
				details = {
					{ "\u{f005} ", hl_group = "NoiceStart" },
					{ "{level} ", },
					{ "{date} ", },
					{ "{event}", },
					{ "{kind}",    before = { ".", hl_group = "NoiceFormatKind" } },
					" ",
					{
						"{title}",
						before = { "[", hl_group = "NoiceBracketBlue" },
						after = { "] ", hl_group = "NoiceBracketBlue" }
					},
					{
						"{cmdline}",
						before = { "\n \u{f120} ", hl_group = "NoiceFormatCmdline" }

					},
					{
						"{message}",
						before = { "\n \u{27a4} ", hl_group = "NoiceArrowLavender" }
					},
					"\n",
				},

			},


		})




		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { fg = colors2.rosewater, bg = "none" })

		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderFilter", { fg = colors2.mauve, bg = "none" })

		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderCmdline", { fg = colors2.yellow, bg = "none" })

		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderInput", { fg = colors2.teal, bg = "none" })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderHelp", { fg = colors2.blue, bg = "none" })


		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderLua", { fg = colors2.flamingo, bg = "none" })

		vim.api.nvim_set_hl(0, "NoiceCmdlineIconCmdline", { fg = colors2.yellow })

		vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = colors2.rosewater })

		vim.api.nvim_set_hl(0, "NoiceCmdlineIconFilter", { fg = colors2.mauve })

		vim.api.nvim_set_hl(0, "NoiceCmdlineIconInput", { fg = colors2.teal })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderIncRename", { fg = colors2.peach })
		vim.api.nvim_set_hl(0, "NoiceCmdlineIconIncRename", { fg = colors2.peach })



		vim.api.nvim_set_hl(0, "NoiceCmdlineIconHelp", { fg = colors2.blue })

		vim.api.nvim_set_hl(0, "NoiceCmdlineIconLua", { fg = colors2.flamingo })
		local set_popup_hl = function()
			vim.api.nvim_set_hl(0, "NoicePopupNormal", { bg = "none", ctermbg = "NONE" })
			vim.api.nvim_set_hl(0, "NoicePopupBorder",
				{ fg = colors2.lavender, bg = "NONE", ctermbg = "NONE" })
		end

		set_popup_hl()
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = set_popup_hl
		})
	end
}
