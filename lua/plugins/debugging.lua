return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()
		require("nvim-dap-virtual-text").setup()


		require("mason-nvim-dap").setup({
			ensure_installed = { "delve", "debugpy", "codelldb" },
			automatic_installation = true,
			handlers = {},
		})
		require("plugins.dap.c_config").setup()
		vim.keymap.set('n', '<F5>', dap.continue, {})
		vim.keymap.set('n', '<F10>', dap.step_over, {})
		vim.keymap.set('n', '<F11>', dap.step_into, {})
		vim.keymap.set('n', '<F12>', dap.step_out, {})
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

		vim.keymap.set("n", "<leader>dq", function()
			require("dap").terminate()
		end, { desc = "DAP: Terminate and Close UI" })
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>dc", dap.continue, {})
	end

}
