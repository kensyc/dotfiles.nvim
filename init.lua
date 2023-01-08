vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

--- Set space as leader
vim.g.mapleader = ' '

require('config')
