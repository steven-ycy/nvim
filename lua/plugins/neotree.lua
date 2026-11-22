return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false,             -- neo-tree will lazily load itself
		keys = {
			{ "<leader>e",  "<cmd>Neotree toggle<cr>",     desc = "Toggle Neo-tree" },
			{ "<leader>o",  "<cmd>Neotree focus<cr>",      desc = "Focus Neo-tree" },
			{ "<leader>ge", "<cmd>Neotree git_status<cr>", desc = "Neo-tree Git Status" },
		},
		opts = {
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = true,
				--	hide_by_name = { "node_modules", ".git", ".DS_Store" },
			},
			window = {
				mappings = {
					["<space>"] = "none",
					["<F5>"] = "refresh",
					["l"] = "open",
					["h"] = "close_node",
					["<leader>cd"] = "navigate_up",
				}
			},
			close_if_last_window = false,
			popup_border_style = "rounded",
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				use_libuv_file_watcher = true,
				hijack_netrw_behavior = "open_default",
			},
			buffers = {
				follow_current_file = { enabled = true },
			},
		},

	}
}
