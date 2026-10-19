-- lazy.nvim
return {
	"folke/noice.nvim",
	event        = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	config       = function()
		-- 設定專屬於此視窗的透明背景與邊框樣式
		local set_popup_hl = function()
			-- 浮動視窗底色與邊框設為透明或微調
			vim.api.nvim_set_hl(0, "NoicePopupNormal", { bg = "none", ctermbg = "NONE" })
			vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = "#81c8be", bg = "NONE", ctermbg = "NONE" })
		end

		set_popup_hl()
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = set_popup_hl,
		})
		vim.keymap.set("n", "<leader>nn", "<cmd>Noice<cr>", { desc = "Search Messages (Noice)" })
		vim.keymap.set("n", "<leader>na", "<cmd>Noice all<cr>", { desc = "Search Messages all(Noice)" })

		require("noice").setup({
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
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
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


		})
	end
}
