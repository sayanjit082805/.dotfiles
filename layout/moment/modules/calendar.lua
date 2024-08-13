local beautiful = require 'beautiful'
local wibox = require 'wibox'
local gears = require 'gears'
local dpi = beautiful.xresources.apply_dpi
local calendar = wibox.widget {
  date = os.date('*t'),
  spacing = dpi(2),
  font = beautiful.font_var,
  widget = wibox.widget.calendar.month,
  fn_embed = function(widget, flag, date)
    local focus_widget = wibox.widget {
      text = date.day,
      align = 'center',
      widget = wibox.widget.textbox,
    }
    local torender = flag == 'focus' and focus_widget or widget
    if flag == 'header' then
      torender.font = beautiful.font_var .. " Bold 14"
    end
    local colors = {
      header = beautiful.accent,
      focus = beautiful.err,
      weekday = beautiful.accent
    }

    local color = colors[flag] or beautiful.fg
    return wibox.widget {
      {
        {
          torender,
          margins = dpi(7),
          widget = wibox.container.margin,
        },
        bg = flag == 'focus' and beautiful.bg2 or beautiful.bg,
        fg = color,
        widget = wibox.container.background,
        shape = flag == 'focus' and gears.shape.circle or nil,
      },
      widget = wibox.container.margin,
      margins = {
        left = 5,
        right = 5,
      }
    }
  end
}



return calendar
