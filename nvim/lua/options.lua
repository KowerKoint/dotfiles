local options = {
    -- 表示
    title = true,
    number = true,

    -- 挙動
    wildmode = { "longest", "full" },
    mouse = "nv",
    smartindent = true,

    -- コーディングスタイル
    expandtab = true,
    shiftwidth = 2,
    softtabstop = 2,
    encoding = "utf-8",
    fileencodings = { "utf-8", "cp932" },

    -- .nvim.lua の読み取り
    exrc = true;
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- LSPなどで表示されるエラーや警告の内容
vim.diagnostic.config({
  virtual_text = true,
})
