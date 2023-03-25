require("neodev").setup()

-- @todo: ensure_installed has a limited server list to auto install
-- a lot of linters, formatters, etc need to be manually installed
-- @todo: expand servers object with lsp's that are available
-- linters/formatters: shellcheck, hadolint, black, isort shfmt, yamllint
local servers = {
    bashls = {},
    pyright = {
        python = {
            analysis = {
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace",
            },
        },
    },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

local on_attach = require("config.keymaps").on_attach
local capabilities = require("cmp_nvim_lsp").default_capabilities (
    vim.lsp.protocol.make_client_capabilities()
)

require("mason").setup()
require("mason-lspconfig").setup({ensure_installed = vim.tbl_keys(servers)})
require("mason-lspconfig").setup_handlers({
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
})
require("fidget").setup()


local null_ls = require("null-ls")

local sources = {
    -- formatting
    null_ls.builtins.formatting.prettierd, -- todo: add prettier-php
    null_ls.builtins.formatting.shfmt,
	null_ls.builtins.formatting.black.with({ extra_args = { "--fast", "--line-length", "79" } }),
	null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.phpcbf,

    -- code actions
    null_ls.builtins.code_actions.gitsigns,

    -- completion
    null_ls.builtins.completion.spell,

    --diagnostics
    null_ls.builtins.diagnostics.hadolint, -- dockerfile lint
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = { "markdown" } }),
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.php,
    null_ls.builtins.diagnostics.phpcs.with({ extra_args= { "--standard", "PSR12" } }),
    null_ls.builtins.diagnostics.phpstan,
    -- null_ls.builtins.diagnostics.ruff,

    -- hover
    null_ls.builtins.hover.printenv,

    -- null_ls.builtins.formatting.xmlformater,
    -- null_ls.builtins.formatting.sql_formatter,
    -- null_ls.builtins.completion.luasnip,
	-- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.diagnostics.codespell,
    -- null_ls.builtins.diagnostics.markdownlint,
    -- null_ls.builtins.diagnostics.shellcheck,
    -- null_ls.builtins.diagnostics.zsh,
    -- null_ls.builtins.diagnostics.twigcs,
    -- null_ls.builtins.diagnostics.curlylint,
    -- null_ls.builtins.diagnostics.luacheck,
    -- null_ls.builtins.diagnostics.php,
    -- null_ls.builtins.diagnostics.psalm,
    -- null_ls.builtins.diagnostics.stylelint,
    -- null_ls.builtins.hover.dictionary,
    -- null_ls.builtins.diagnostics.mypy.with({ extra_args = { "--cache-dir", os.getenv("XDG_CACHE_HOME") .. "/mypy" } }), -- @todo: add env variable fallback
}

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
})
