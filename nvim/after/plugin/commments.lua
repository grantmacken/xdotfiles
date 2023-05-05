local ok, comment = pcall(require, "Comment")
if not ok then
  return
end

local ts_ok, ts_context_commentstring = pcall(require, "ts_context_commentstring")
if not ts_ok then
  return
end

require("Comment").setup {
  -- LHS of operator-pending mapping in NORMAL + VISUAL mode
  opleader = {
    line = "gc", -- line-comment keymap
    block = "gb"-- block-comment keymap
  },

  -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
  mappings = {
    -- operator-pending mapping
    -- Includes:
    --  `gcc`               -> line-comment  the current line
    --  `gcb`               -> block-comment the current line
    --  `gc[count]{motion}` -> line-comment  the region contained in {motion}
    --  `gb[count]{motion}` -> block-comment the region contained in {motion}
    basic = true,

    -- extra mapping
    -- Includes `gco`, `gcO`, `gcA`
    extra = true,

    -- extended mapping
    -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = true,
  },

  -- LHS of toggle mapping in NORMAL + VISUAL mode
  toggler = {
    -- line-comment keymap
    --  Makes sense to be related to your opleader.line
    line = "gcc",

    -- block-comment keymap
    --  Make sense to be related to your opleader.block
    block = "gbc",
  },

  -- Pre-hook, called before commenting the line
  --    Can be used to determine the commentstring value
  pre_hook = function(ctx)
    local U = require "Comment.utils"

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,
  -- Post-hook, called after commenting is done
  --    Can be used to alter any formatting / newlines / etc. after commenting
  post_hook = nil,

  -- Can be used to ignore certain lines when doing linewise motions.
  --    Can be string (lua regex)
  --    Or function (that returns lua regex)
  ignore = nil,
}

-- local comment_ft = require "Comment.ft"
-- comment_ft.set("lua", { "--%s", "--[[%s]]" })
