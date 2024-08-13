-- keybinds haha
----------------
-- Copyleft © 2022 Saimoomedits

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local lmachi = require("mods.layout-machi")
local bling = require("mods.bling")
local misc = require("misc")
local playerctl = require("mods.bling").signal.playerctl.lib()
local audiodaemon = require("daemons.audio")
local lightdaemon = require("daemons.light")
local widgets = require("layout.menu")
-- require("layout.lockscreen").init()

-- vars/misc
-- ~~~~~~~~~

-- modkey
local modkey = "Mod4"

-- modifer keys
local shift = "Shift"
local ctrl = "Control"
local alt = "Mod1"

-- Configurations
-- ~~~~~~~~~~~~~~

-- mouse keybindings
-- awful.mouse.append_global_mousebindings({
-- 	awful.button({}, 3, function()
-- 		widgets.mainmenu:toggle()
-- 	end),
-- 	awful.button({}, 4, awful.tag.viewprev),
-- 	awful.button({}, 5, awful.tag.viewnext),
-- })

-- launchers
awful.keyboard.append_global_keybindings({

	awful.key({ modkey }, "Return", function()
		awful.spawn(user_likes.term)
	end, { description = "open terminal", group = "launcher" }),

	awful.key({ modkey }, "b", function()
		awful.spawn.with_shell(user_likes.web)
	end, { description = "open web browser", group = "launcher" }),

	awful.key({ modkey }, "r", function()
		-- awful.spawn.with_shell("rofi -show drun -config ~/.config/rofi/custom_launcher.rasi")
		awesome.emit_signal('toggle::applauncher')
	end, { description = "rofi bin apps", group = "launcher" }),

	awful.key({ modkey }, "t", function()
		awful.spawn.with_shell("neovide")
	end, { description = "neovide", group = "launcher" }),

	awful.key({ modkey }, "f", function()
		awful.spawn.with_shell("nemo")
	end, { description = "nemo file exp", group = "launcher" }),

	awful.key({ modkey }, "e", function()
		-- awful.spawn(misc.rofiCommand)
		app_launcher:toggle()
		awesome.emit_signal("launcher::toggled", true)
	end, { description = "open launcher", group = "launcher" }),

	awful.key({ modkey }, "p", function()
		awful.spawn("bspcolorpicker", false)
	end, { description = "exec color picker", group = "launcher" }),

	-- awful.key({ modkey }, "a", function()
	-- 	cc_toggle(screen.primary)
	-- end, { description = "toggle control center", group = "launcher" }),

	awful.key({ modkey }, "w", function()
		awful.spawn("networkmanager_dmenu")
	end, { description = "open wifi menu", group = "launcher" }),

	awful.key({ modkey, shift }, "w", function()
		awesome.emit_signal("toggle::wallswitcher")
	end, { description = "open wallpaper switcher", group = "launcher" }),

	awful.key({ modkey, shift }, "d", function()
		awesome.emit_signal("toggle::lock")
	end, { description = "show lockscreen", group = "launcher" }),
})

-- control/media
awful.keyboard.append_global_keybindings({

	awful.key({}, "XF86MonBrightnessUp", function()
		-- awful.spawn("brightnessctl set 5%+ -q", false)
		lightdaemon:increase_brightness(5)
	end, { description = "increase brightness", group = "control" }),

	awful.key({}, "XF86MonBrightnessDown", function()
		-- awful.spawn("brightnessctl set 5%- -q", false)
		lightdaemon:decrease_brightness(5)
	end, { description = "decrease brightness", group = "control" }),

	awful.key({}, "Print", function()
		awful.spawn.with_shell("flameshot full")
	end, { description = "screenshot full", group = "control" }),

	awful.key({ modkey }, "Print", function()
		awful.spawn.with_shell("flameshot gui")
	end, { description = "screenshot menu", group = "control" }),

	awful.key({}, "XF86AudioRaiseVolume", function()
		audiodaemon:sink_volume_up(nil, 5)
		-- update_value_of_volume()
	end, { description = "Increase volume", group = "System" }),

	awful.key({}, "XF86AudioLowerVolume", function()
		audiodaemon:sink_volume_down(nil, 5)
	end, { description = "Lower volume", group = "System" }),

	awful.key({}, "XF86AudioLowerVolume", function()
		audiodaemon:sink_volume_down(nil, 5)
		-- update_value_of_volume()
	end, { description = "Lower volume", group = "control" }),

	awful.key({}, "XF86AudioMute", function()
		awful.spawn("amixer -D pipewire set Master toggle", false)
		-- updateAllVolumeSignals()
	end, { description = "mute volume", group = "control" }),

	awful.key({ modkey }, "F11", function()
		misc.musicMenu()
	end, { description = "screenshot", group = "control" }),
})

-- awesome yeah!
awful.keyboard.append_global_keybindings({

	awful.key({ modkey, shift }, "h", hotkeys_popup.show_help, { description = "show this help window", group = "awesome" }),
	awful.key({ modkey, ctrl }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

	awful.key({ modkey, shift }, "e", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey, shift }, "q", function()
		-- require("mods.exit-screen")
		awesome.emit_signal("toggle::exit")
	end, { description = "show exit screen", group = "modules" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tags" }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "h", function()
		awful.client.focus.bydirection("left")
		bling.module.flash_focus.flashfocus(client.focus)
	end, { description = "focus left", group = "client" }),

	awful.key({ modkey }, "l", function()
		awful.client.focus.bydirection("right")
		bling.module.flash_focus.flashfocus(client.focus)
	end, { description = "focus right", group = "client" }),

	awful.key({ modkey, ctrl }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),

	awful.key({ modkey, ctrl }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),

	awful.key({ modkey, ctrl }, "n", function()
		local c = awful.client.restore()
		if c then
			c:activate({ raise = true, context = "key.unminimize" })
		end
	end, { description = "restore minimized", group = "client" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({

	awful.key({ modkey, shift }, "l", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),

	awful.key({ modkey, shift }, "h", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),

	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey, alt }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),

	awful.key({ modkey, alt }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	awful.key({ modkey, alt }, "j", function()
		awful.client.incwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),

	awful.key({ modkey, alt }, "k", function()
		awful.client.incwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	-- awful.key({ modkey, shift }, "k", function()
	-- 	awful.tag.incnmaster(1, nil, true)
	-- end, { description = "increase the number of master clients", group = "layout" }),
	--
	-- awful.key({ modkey, shift }, "j", function()
	-- 	awful.tag.incnmaster(-1, nil, true)
	-- end, { description = "decrease the number of master clients", group = "layout" }),

	awful.key({ modkey, ctrl }, "l", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),

	awful.key({ modkey, ctrl }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

	awful.key({ modkey, }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),

	awful.key({ modkey, shift }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select next", group = "layout" }),

	-- layout machi
	awful.key({ modkey }, ".", function()
		lmachi.default_editor.start_interactive()
	end, { description = "edit current layout", group = "layout" }),

	awful.key({ modkey, shift }, ".", function()
		lmachi.switcher.start(client.focus)
	end, { description = "switch between windows for a machi layout", group = "layout" }),
})

-- tag related keys
awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { modkey },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),

	awful.key({
		modifiers = { modkey, ctrl },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),

	awful.key({
		modifiers = { modkey, shift },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),

	awful.key({
		modifiers = { modkey, ctrl, shift },
		keygroup = "numrow",
		description = "toggle focused client on tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	}),

	awful.key({
		modifiers = { modkey },
		keygroup = "numpad",
		description = "select layout directly",
		group = "layout",
		on_press = function(index)
			local t = awful.screen.focused().selected_tag
			if t then
				t.layout = t.layouts[index] or t.layout
			end
		end,
	}),
})

-- music control
awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "Left", function()
		playerctl:previous()
	end, { description = "previous song", group = "media control" }),
	awful.key({ modkey }, "Right", function()
		playerctl:next()
	end, { description = "next song", group = "media control" }),
	awful.key({ modkey }, "Down", function()
		playerctl:play_pause()
	end, { description = "play/pause song", group = "media control" }),
})

-- mouse mgmt
client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({

		awful.button({}, 1, function(c)
			c:activate({ context = "mouse_click" })
		end),

		awful.button({ modkey }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_move" })
		end),

		awful.button({ modkey }, 3, function(c)
			c:activate({ context = "mouse_click", action = "mouse_resize" })
		end),
	})
end)

-- client mgmt
client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key({ modkey }, "m", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, { description = "toggle fullscreen", group = "client" }),

		awful.key({ modkey }, "q", function(c)
			c:kill()
		end, { description = "close", group = "client" }),

		awful.key({ modkey }, "x", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
		awful.key({ modkey, ctrl }, "Return", function(c)
			c:swap(awful.client.getmaster())
		end, { description = "move to master", group = "client" }),

		awful.key({ modkey }, "o", function(c)
			c:move_to_screen()
		end, { description = "move to screen", group = "client" }),

		awful.key({ modkey }, "k", function(c)
			c.ontop = not c.ontop
		end, { description = "toggle keep on top", group = "client" }),

		awful.key({ modkey }, "n", function(c)
			c.minimized = true
		end, { description = "minimize", group = "client" }),

		-- awful.key({ alt }, "Tab", function()
		-- 	awesome.emit_signal("window_switcher::turn_on")
		-- end),


		awful.key({ modkey }, "z", function(c)
			c.maximized = not c.maximized
			c:raise()
		end, { description = "(un)maximize", group = "client" }),

	})
end)

awful.keygrabber {
	keybindings = {
		awful.key {
			modifiers = { "Mod1" },
			key = "Tab",
			on_press = function()
				awesome.emit_signal "winswitch::next"
			end,
		},
	},
	root_keybindings = {
		awful.key {
			modifiers = { "Mod1" },
			key = "Tab",
			on_press = function()
			end,
		},
	},
	stop_key = "Mod1",
	stop_event = "release",
	start_callback = function()
		awesome.emit_signal "toggle::winswitch"
	end,
	stop_callback = function()
		awesome.emit_signal "winswitch::raise"
		awesome.emit_signal "toggle::winswitch"
	end,
	export_keybindings = true,
}
