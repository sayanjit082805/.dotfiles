local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local helpers = require("helpers")
local animation = require("mods.animation")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local currentTheme = beautiful.name
-- local DIR = gears.filesystem.get_configuration_dir() .. "images/walls/"
local DIR = gears.filesystem.get_configuration_dir() .. "theme/wallpapers/" .. currentTheme .. "/"
local curr = beautiful.wallpaper
local currPath
local elems = wibox.widget {
  {
    layout = wibox.layout.fixed.vertical,
    spacing = 20,
    id = "switcher"
  },
  forced_height = 200,
  layout = require("mods.overflow").vertical
}

local setWall = function(path)
  gears.wallpaper.maximized(curr, s, beautiful.bg_2)
  awful.spawn.with_shell('setWall ' .. path .. " " .. beautiful.name)
end

local imageWidget = wibox.widget {
  image = curr,
  forced_width = 600,
  horizontal_fit_policy = "fit",
  vertical_fit_policy = "fit",
  widget = wibox.widget.imagebox,
}

awful.screen.connect_for_each_screen(function(s)
  local wallswitcher = wibox {
    width = dpi(600),
    height = dpi(600),
    shape = helpers.rrect(8),
    bg = beautiful.bg_color,
    ontop = true,
    visible = false
  }

  wallswitcher:setup {
    {
      {
        {
          {
            font = beautiful.icofont .. " 12",
            markup = helpers.colorize_text("󰝥", beautiful.red_color),
            widget = wibox.widget.textbox,
            align = "left",
            valign = "center",
            buttons =
            {
              awful.button({}, 1, function() awesome.emit_signal('toggle::wallswitcher') end),
            }
          },
          nil,
          {
            font = beautiful.font_var .. " 12",
            markup = helpers.colorize_text("WALLPAPERS", beautiful.fg_color),
            widget = wibox.widget.textbox,
            align = "right",
            valign = "center",
          },
          layout = wibox.layout.align.horizontal
        },
        widget = wibox.container.margin,
        margins = 10,
      },
      widget = wibox.container.background,
      bg = beautiful.bg_2 .. 'cc'
    },
    {
      widget = wibox.container.margin,
      margins = 20,
      elems,
    },
    {
      {
        imageWidget,
        {
          {
            widget = wibox.widget.textbox,
          },
          bg = {
            type = "linear",
            from = { 0, 0 },
            to = { 250, 0 },
            stops = { { 0, beautiful.bg_color .. "99" }, { 1, beautiful.bg_color .. "cc" } }
          },
          widget = wibox.container.background,
        },
        {
          {
            {
              {
                markup = "Open Folder",
                font   = beautiful.font_var .. " 12",
                widget = wibox.widget.textbox
              },
              widget = wibox.container.margin,
              margins = 12,
              buttons = {
                awful.button({}, 1, function()
                  awful.spawn.with_shell("nautilus ~/.config/awesome/theme/wallpapers/" .. beautiful.name)
                end)
              },
            },
            {
              {
                markup = "Set Wallpaper",
                font   = beautiful.font_var .. " 12",
                widget = wibox.widget.textbox
              },
              widget = wibox.container.margin,
              margins = 12,
              buttons = {
                awful.button({}, 1, function()
                  setWall(currPath)
                end)
              },
            },
            layout = wibox.layout.fixed.horizontal
          },
          widget = wibox.container.place,
          halign = 'right',
          valign = 'bottom',
        },
        layout = wibox.layout.stack
      },
      widget = wibox.container.margin,
      bottom = 20,
      left = 20,
      right = 20,
    },
    layout = wibox.layout.fixed.vertical
  }

  local slide = animation:new({
    duration = 0.6,
    pos = 0 - wallswitcher.height,
    easing = animation.easing.inOutExpo,
    update = function(_, pos)
      wallswitcher.y = s.geometry.y + pos
    end,
  })

  local slide_end = gears.timer({
    single_shot = true,
    timeout = 0.43,
    callback = function()
      wallswitcher.visible = false
    end,
  })

  local close = function()
    slide_end:again()
    slide:set(0 - wallswitcher.height)
  end
  local function refresh()
    elems:reset()
    for path in io.popen("cd " .. DIR .. " && find . -maxdepth 1 | tail -n +2"):lines() do
      path = string.sub(path, 3)
      if not os.execute("cd '" .. DIR .. path .. "'") then
        if curr == DIR .. path then
          currPath = path
        end
        local widget = wibox.widget {
          {
            markup  = curr == DIR .. path and helpers.colorize_text(path, beautiful.fg_color) or path,
            font    = beautiful.font_var .. " 12",
            align   = "left",
            valign  = "center",
            widget  = wibox.widget.textbox,
            buttons = {
              awful.button({}, 1, function()
                curr = DIR .. path
                currPath = path
                imageWidget.image = curr
                refresh()
              end)
            },
          },
          widget = wibox.container.margin,
          bottom = 10
        }
        elems:add(widget)
      end
    end
  end


  awesome.connect_signal("toggle::wallswitcher", function()
    if wallswitcher.visible then
      close()
    elseif not wallswitcher.visible then
      slide:set(50 + beautiful.useless_gap * 2)
      wallswitcher.visible = true
      refresh()
    end
    awful.placement.top(wallswitcher)
  end)
end)
