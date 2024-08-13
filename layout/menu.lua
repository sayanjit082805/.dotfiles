local _M = {}
local awful = require("awful")
local beautiful = require("beautiful")
-- local apps = require 'config.apps'
local gcolor = require('gears.color')
local wibox = require("wibox")
local gfilesystem = require('gears.filesystem')
local icondir = gfilesystem.get_configuration_dir() .. 'images/desk/'

local cm = require 'mods.menu'

local menu = cm {
  widget_template = wibox.widget {
    {
      {
        {
          {
            widget = wibox.widget.imagebox,
            resize = true,
            valign = 'center',
            halign = 'center',
            id = 'icon_role',
          },
          widget = wibox.container.constraint,
          stragety = 'exact',
          width = 40,
          height = 24,
          id = 'const',
        },
        {
          widget = wibox.widget.textbox,
          valign = 'center',
          halign = 'left',
          id = 'text_role',
        },
        layout = wibox.layout.fixed.horizontal,
      },
      widget = wibox.container.margin,
      margins = 6,
    },
    forced_width = 100,
    widget = wibox.container.background,
  },
  spacing = 10,
  entries = {
    {
      name = 'Browser',
      icon = gcolor.recolor_image(icondir .. 'web.svg', beautiful.purple_color),
      callback = function()
        awesome.spawn('firefox')
      end,
    },
    {
      name = 'Files',
      icon = gcolor.recolor_image(icondir .. 'folder.svg', beautiful.green_color),
      callback = function()
        awful.spawn("nautilus")
      end,
    },
    {
      name = 'New Shortcut',
      icon = gcolor.recolor_image(icondir .. 'launch.svg', beautiful.yellow_color),
      callback = function()
        awesome.emit_signal('create::something', 'shortcut')
      end,
    },
    {
      name = 'Editor',
      icon = gcolor.recolor_image(icondir .. 'text.svg', beautiful.accent),
      callback = function()
        awful.spawn("code")
      end,
    },
    {
      name = 'Applications',
      icon = gcolor.recolor_image(icondir .. 'search.svg', beautiful.red_2),
      callback = function()
        awful.spawn("rofi -show drun -config ~/.config/rofi/custom_launcher.rasi")
      end,
    },
    {
      name = 'Terminal',
      icon = gcolor.recolor_image(icondir .. 'terminal.svg', beautiful.accent_2),
      callback = function()
        awful.spawn.with_shell('wezterm')
      end,
    },
    {
      name = 'Awesome',
      icon = gcolor.recolor_image(icondir .. 'awesomewm.svg', beautiful
        .accent),
      submenu = {
        {
          name = 'Open Docs',
          icon = gcolor.recolor_image(icondir .. 'web.svg', beautiful.green_2),
          callback = function()
            awful.spawn.with_shell("firefox https://awesomewm.org/apidoc/documentation/07-my-first-awesome.md.html#")
          end,
        },
        {
          name = 'Open Config',
          icon = gcolor.recolor_image(icondir .. 'text.svg', beautiful.accent),
          callback = function()
            awful.spawn.with_shell('wezterm -e sh -c "cd ~/.config/awesome ; nvim rc.lua ; $SHELL"')
          end,
        },
        {
          name = 'Restart',
          icon = gcolor.recolor_image(icondir .. 'refresh.svg', beautiful.red_color),
          callback = function()
            awesome.restart()
          end,
        },
        {
          name = 'Exit',
          icon = gcolor.recolor_image(icondir .. 'logout.svg', beautiful.accent_3),
          callback = function()
            awesome.quit()
          end,
        },
      }
    },
  }
}
_M.mainmenu = menu


return _M
