local helpers = require('helper.helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
  {
    -- TODO NOTE
    s({trig="todo", snippetType="autosnippet"},
      {
        t("- [ ] "),
        d(1, get_visual),
      }
    ),
    -- LINK; CAPTURE TEXT IN VISUAL
    s({trig="LL", wordTrig=true, snippetType="autosnippet"},
      fmta(
        [[[<>](<>)]],
        {
          d(1, get_visual),
          i(2),
        }
      )
    ),
    -- LINK; CAPTURE URL IN VISUAL
    s({trig="LU", wordTrig=true, snippetType="autosnippet"},
      fmta(
        [[[<>](<>)]],
        {
          i(1),
          d(2, get_visual),
        }
      )
    ),
    -- BOLDFACE TEXT
    s({trig="tbb", snippetType="autosnippet"},
      fmta(
        [[**<>**]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- ITALIC TEXT
    s({trig="tii", snippetType="autosnippet"},
      fmta(
        [[*<>*]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- UNDERLINED TEXT
    s({trig="uu", snippetType="autosnippet"},
      fmt(
        [[<u>{}</u>]],
        {
          d(1, get_visual),
        }
      )
    ),
  }

