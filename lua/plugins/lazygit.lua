return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
	},
	config = function()
		vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
		vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
		vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } -- customize lazygit popup window border characters
		vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
		vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

		vim.g.lazygit_use_custom_config_file_path = 1 -- config file path is evaluated if this value is 1
		vim.g.lazygit_config_file_path = '' -- custom config file path
		-- OR
		vim.g.lazygit_config_file_path = { vim.fn.expand("~/.config/lazygit/config.yml"),
			vim.fn.expand("~/.config/lazygit/colorscheme/yellow.yml"),
		}                              -- table of custom config file paths

		vim.g.lazygit_on_exit_callback = nil -- optional function callback when exiting lazygit (useful for example to refresh some UI elements after lazy git has made some changes)
	end
}
