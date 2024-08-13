local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local wibox = require("wibox")

local notifbox = require("layout.notify.modules.notifs.build")
local cpu = require("layout.notify.resources.cpu")
local ram = require("layout.notify.resources.ram")
local hdd = require("layout.notify.resources.hdd")

awful.screen.connect_for_each_screen(function(s)
  local moment = wibox({
    type = "dock",
    shape = helpers.rrect(4),
    screen = s,
    width = dpi(480),
    height = 800,
    bg = beautiful.bg,
    ontop = true,
    visible = false
  })


  moment:setup {
    {
      {
        {
          {
            ram,
            cpu,
            hdd,
            spacing = dpi(30),
            layout = wibox.layout.fixed.horizontal,
          },
          layout = wibox.layout.align.vertical,
          expand = "none",
        },
        margins = dpi(25),
        widget = wibox.container.margin
      },
      widget = wibox.container.background,
      bg = beautiful.bg_color,
      forced_height = dpi(150),
    },
    {
      {
        nil,
        notifbox,
        nil,
        layout = wibox.layout.align.vertical,
      },
      margins = dpi(15),
      widget = wibox.container.margin,
    },
    layout = wibox.layout.align.vertical
  }

  awful.placement.bottom_right(moment, { honor_workarea = true, margins = beautiful.useless_gap * 2 })
  awesome.connect_signal("toggle::notify", function()
    moment.visible = not moment.visible
  end)
end)
