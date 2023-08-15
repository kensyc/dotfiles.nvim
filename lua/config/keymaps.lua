-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Paste without yanking
-- vim.keymap.set("v", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- stay at start of the line after J (merges line below with current line)
vim.keymap.set("n", "J", "mzJ`z")

-- center screen after scrolling or going through search results
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Files tree keymaps
vim.keymap.set("n", "<leader>n", "<cmd>Neotree filesystem reveal<CR>")
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "_", "<cmd>Oil --float .<CR>")
vim.keymap.set("n", "<leader>N", "<cmd>Neotree toggle reveal<CR>")


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
vim.keymap.set("n", "<M-J>", "<C-W>+")
vim.keymap.set("n", "<M-K>", "<C-W>-")
vim.keymap.set("n", "<M-H>", "<C-W><")
vim.keymap.set("n", "<M-L>", "<C-W>>")

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
vim.keymap.set("n", "<leader>fz",
    function()
        require("telescope.builtin").current_buffer_fuzzy_find(
            require('telescope.themes').get_dropdown {
                windblend = 10,
                previewer = false,
            }
        )
    end
)
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<leader>fp", require("telescope.builtin").live_grep)
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<CR>')
vim.keymap.set("n", "<leader>u", '<cmd>Telescope undo<CR>')

vim.keymap.set("n", "<leader>td", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<leader>tp", require("telescope.builtin").tags)
vim.keymap.set("n", "<leader>tf", require("telescope.builtin").current_buffer_tags)

local undo_mappings = {
    i = {
        ["<CR>"] = require("telescope-undo.actions").yank_additions,
        ["<S-CR>"] = require("telescope-undo.actions").yank_deletions,
        ["<C-CR>"] = require("telescope-undo.actions").restore,
    }
}

-- Diagnostics
vim.keymap.set("n", "<leader>df", "<cmd>lua vim.diagnostic.open_float()<CR>")
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
    -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>fo", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
    vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, bufopts)
    vim.keymap.set("n", "<leader>dd", require("telescope.builtin").diagnostics, bufopts)

    -- go to definition in vsplit
    vim.keymap.set("n", "<C-W><C-V>", "<C-W><C-V><C-W><C-L><cmd>lua vim.lsp.buf.definition()<CR>", bufopts)

    -- unused
    -- vim.keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', buffopts)
    -- vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', buffopts)
    -- vim.keymap.set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', buffopts)
end

vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
vim.keymap.set({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

local cmp = require("cmp")
local cmp_keys = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-n>"] = cmp.mapping.select_next_item({behavior = cmp.ConfirmBehavior.Replace}),
    ["<C-p>"] = cmp.mapping.select_prev_item({behavior = cmp.ConfirmBehavior.Replace}),
}

local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
vim.keymap.set("i", "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

local gitsigns_on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>gS', gs.stage_buffer)
    map('n', '<leader>gu', gs.undo_stage_hunk)
    map('n', '<leader>gR', gs.reset_buffer)
    map('n', '<leader>gp', gs.preview_hunk)
    map('n', '<leader>gB', function() gs.blame_line { full = true } end)
    map('n', '<leader>gb', gs.toggle_current_line_blame)
    map('n', '<leader>gd', gs.diffthis)
    map('n', '<leader>gD', function() gs.diffthis('~') end)
    map('n', '<leader>gt', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ig', ':<C-U>Gitsigns select_hunk<CR>')
end


return {
    on_attach = on_attach,
    cmp_keys = cmp_keys,
    treesitter_keymaps = treesitter_keymaps,
    undo_mappings = undo_mappings,
    gitsigns_on_attach = gitsigns_on_attach,
}
