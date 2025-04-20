-- lua/plugins/debug.lua
-- Отладка (DAP) для Go и других языков
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"leoluz/nvim-dap-go",
		},
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "DAP Continue/Start",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "DAP Step Over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "DAP Step Into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "DAP Step Out",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "DAP Conditional Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").terminate()
				end,
				desc = "DAP Stop",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "DAP REPL",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "DAP Toggle UI",
			},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()
			local dap = require("dap")
			local dapui = require("dapui")
			dap.listeners.after.event_initialized["dapui"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui"] = function()
				dapui.close()
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		config = function()
			require("dap-go").setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio", -- <-- вот эта строчка нужна
		},
		config = function()
			require("dapui").setup()
			local dap = require("dap")
			local dapui = require("dapui")
			dap.listeners.after.event_initialized["dapui"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui"] = function()
				dapui.close()
			end
		end,
	},
}
