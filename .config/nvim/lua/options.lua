local options = {
    -- 表示
    title = true,
    number = true,
    makeprg = 'make EXTRA_CFLSGS=-fcolor-diagnostic',

    -- 挙動
    wildmode = { "longest", "full" },
    mouse = "nv",
    smartindent = true,

    -- コーディングスタイル
    expandtab = true,
    shiftwidth = 4,
    softtabstop = 4,
    encoding = "utf-8",
    fileencodings = { "utf-8", "cp932" },
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end
