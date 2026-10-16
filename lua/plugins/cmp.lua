return {
  -- 1. 補全引擎本體
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- 進入插入模式時自動載入
  dependencies = {
    -- 2. 與 LSP 連線的來源 (就是剛剛那顆報錯的外掛)
    "hrsh7th/cmp-nvim-lsp",
    -- 3. 其他常見來源 (可選)
    "hrsh7th/cmp-buffer", -- 補全當前檔案內出現過的字詞
    "hrsh7th/cmp-path",   -- 補全檔案路徑
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      -- 補全選單按鍵設定
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- 手動叫出補全選單
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 按 Enter 確認選取
        ["<Tab>"] = cmp.mapping.select_next_item(), -- 下一個候選項目
        ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- 上一個候選項目
      }),

      -- 補全來源優先順序
      sources = cmp.config.sources({ 
        { name = "nvim_lsp" }, -- 優先吃 LSP 提示
        { name = "buffer" },   -- 其次吃 buffer 內字詞
        { name = "path" },     -- 路徑補全
      }),
    })
  end,
}
