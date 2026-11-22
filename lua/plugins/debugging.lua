return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	keys = {
		{ "<F5>",       function() require("dap").continue() end,          desc = "Debug: Continue" },
		{ "<F10>",      function() require("dap").step_over() end,         desc = "Debug: Step Over" },
		{ "<F8>",       function() require("dap").step_into() end,         desc = "Debug: Step Into" },
		{ "<F12>",      function() require("dap").step_out() end,          desc = "Debug: Step Out" },
		{ "<leader>dc", function() require("dap").continue() end,          desc = "Debug: Continue" },
		{ "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
		{ "<leader>du", function() require("dapui").toggle() end,          desc = "Debug: Toggle UI" },
		{ "<leader>dq", function() require("dap").terminate() end,         desc = "Debug: Terminate and Close UI" },
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
	end,
}
