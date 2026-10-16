local conf = require("telescope.config").values

-- 2. 宣告這個輔助函式（完全合法，不會報錯）
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
return {

    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require("harpoon")

        -- 初始化 harpoon
        harpoon:setup({})
	vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
	vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

	vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
	vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
	vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
	vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set("n", "<C-P>", function() harpoon:list():prev() end)
	vim.keymap.set("n", "<C-N>", function() harpoon:list():next() end)
	vim.keymap.set("n", "<leader>fl", function() toggle_telescope(harpoon:list()) end,
	    { desc = "Open harpoon window" })
    end,
}
