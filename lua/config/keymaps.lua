-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Paste without yanking
vim.keymap.set("v", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>")

-- TODO: nohl keymap
--

-- Files tree keymaps
vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>nr", "<cmd>NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>nf", "<cmd>NvimTreeFindFile<CR>")

-- Switch buffers
vim.keymap.set("n", "<leader>j", "<C-W><C-J>")
vim.keymap.set("n", "<leader>k", "<C-W><C-K>")
vim.keymap.set("n", "<leader>l", "<C-W><C-L>")
vim.keymap.set("n", "<leader>h", "<C-W><C-H>")

vim.keymap.set("n", "<leader>o", "<cmd>tabprev<CR>")
vim.keymap.set("n", "<leader>i", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>tabclose<CR>")
vim.keymap.set("n", "<leader>L", "<cmd>+tabm<CR>") -- todo: add ability to position (tabm +{i})
vim.keymap.set("n", "<leader>H", "<cmd>-tabm<CR>")

-- resize splits
vim.keymap.set("n", "<C-J>", "<C-W>+")
vim.keymap.set("n", "<C-K>", "<C-W>-")
vim.keymap.set("n", "<C-H>", "<C-W><")
vim.keymap.set("n", "<C-L>", "<C-W>>")

-- go to definition in vsplit
vim.keymap.set("n", "<C-w><C-d>", "<C-W><C-d><C-W>L")

-- Treesitter keymaps
local treesitter_keymaps = {
    init_selection = "gnn",
    node_incremental = "grn",
    scope_incremental = "grc",
    node_decremental = "grm",
}

-- Telescope
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles)

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>fz", require("telescope.builtin").current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<leader>fp", require("telescope.builtin").live_grep)
-- vim.keymap.set('n', '<leader>f', '<cmd>Telescope file_browser<CR>')

vim.keymap.set("n", "<leader>td", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<leader>tp", require("telescope.builtin").tags)
vim.keymap.set("n", "<leader>tf", require("telescope.builtin").current_buffer_tags)

-- Diagnostics
vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")

-- unused
-- vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

-- LSP
local on_attach = function(_, bufnr)
    local bufopts = { buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>fo", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
    vim.keymap.set("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols, bufopts)
    vim.keymap.set("n", "<leader>ld", require("telescope.builtin").diagnostics, bufopts)

    -- unused
    -- vim.keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', buffopts)
    -- vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', buffopts)
    -- vim.keymap.set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', buffopts)
end

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_keys = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
}

return {
    on_attach = on_attach,
    cmp_keys = cmp_keys,
    treesitter_keymaps = treesitter_keymaps,
}
