local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

local function get_namespaces(composer_config)
  if type(composer_config) ~= 'string' then
    return {}
  end

  local _, _, result = string.find(composer_config, "psr%-4.-[%s\n]*({[%s\n]*.-[%s\n]*})")
  result = result:gsub('%s', '')

  local ns_path_map = {}
  for k, v in string.gmatch(result, '"([%w\\]+)":"([%w/]+)"') do
    ns_path_map[v] = k
  end

  return ns_path_map
end

local function format_namespace(namespaces, filename)
  local ns = nil
  local path = nil
  local current_path = vim.api.nvim_buf_get_name(0)

  for relative_path, namespace in pairs(namespaces) do
    if string.find(current_path, relative_path) then
      path = relative_path
      ns = namespace
      break
    end
  end

  if ns == nil then
    return ""
  end

  ns = ns .. current_path:gsub(".-" .. path, "")
  ns = ns:gsub("/" .. filename, "")
  ns = ns:gsub([[\\]], [[\]])
  ns = ns:gsub("/", "\\")

  return ns
end

local function get_composer_config()
  local composer_path = vim.fs.find('composer.json', {
    upward = true,
    stop = vim.loop.os_homedir(),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
  })

  composer_path = composer_path[1]

  if composer_path == nil then
    return ""
  end

  local file = io.open(composer_path, "rb")
  if file~=nil then
    return file:read("*a")
  end

  return ""
end

ls.env_namespace(
  "PHP",
  { vars = { NS = get_namespaces(get_composer_config()) } }
)

local phpfileTemplate = [[
<?php

declare(strict_types=1);

{}

{} {}
{{
{}
}}
]]

ls.add_snippets(
  'php',
  {
    s('class',
      fmt(
        phpfileTemplate, {
          f(function (args, snip)
            if not snip.env.PHP_NS then
              return ""
            end

            local ns = format_namespace(snip.env.PHP_NS, snip.env.TM_FILENAME)

            return "namespace " .. ns .. ";"
          end, {}),
          c(1, {
            t('final class'),
            t('class'),
            t('final readonly class'),
            t('abstract class')
          }),
          f(function(args, snip)
            return snip.env.TM_FILENAME:gsub('.php', '')
          end, {}),
          i(2)
        })
    ),
  }
);
