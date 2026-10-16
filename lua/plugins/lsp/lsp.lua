return {
  -- 1. 指定要安裝/載入的插件名稱 (nvim-cmp 的 LSP 來源外掛)
  "hrsh7th/cmp-nvim-lsp",

  -- 2. 設定延遲載入 (Lazy loading) 的觸發時機
  event = { "BufReadPre", "BufNewFile" },

  -- 3. 插件載入後要執行的配置函式
  config = function()
    -- 匯入 cmp-nvim-lsp 模組
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- 取得擴充後的 capabilities (宣告支援程式碼片段 Snippets、自動匯入等進階補全)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- 將此補全能力全域套用到所有啟動的 LSP 伺服器
    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end,
}
