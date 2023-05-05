vim.notify = require('notify')

vim.notify('scratch', 'warn', { render = 'minimal', timeout = 500 })

local buf = require('my.buffers')

buf.scratch()
