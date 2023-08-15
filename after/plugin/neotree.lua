-- vim.fn.sign_define("DiagnosticSignError",
--     {text = " ", texthl = "DiagnosticSignError"})
-- vim.fn.sign_define("DiagnosticSignWarn",
--     {text = " ", texthl = "DiagnosticSignWarn"})
-- vim.fn.sign_define("DiagnosticSignInfo",
--     {text = " ", texthl = "DiagnosticSignInfo"})
-- vim.fn.sign_define("DiagnosticSignHint",
--     {text = "", texthl = "DiagnosticSignHint"})

require('neo-tree').setup({
  window = {
    mappings = {
      ['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
      ['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
      ['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
      ['-'] = "open_oil",
    },
  },
  filesystem = {
    hijack_netrw_behavior = 'disabled'
  },
  commands = {
    open_oil = function(state)
      local node = state.tree:get_node()
      local path = node:get_id():gsub("[^/]*$", "")
      vim.api.nvim_command(string.format("Oil --float %s", path))
    end,
  },
})
