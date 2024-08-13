-- A random rice. i guess.
-- source: https://github.com/saimoomedits/dotfiles |-| Copyleft © 2022 Saimoomedits
------------------------------------------------------------------------------------

pcall(require, "luarocks.loader")
local naughty = require("naughty")

-- home variable 🏠
home_var = os.getenv("HOME")

-- require("awful").spawn.easy_async_with_shell(home_var .. "/.config/awesome/misc/scripts/monitor.sh") -- disable laptop monitor

-- user preferences ⚙️
user_likes = {

	-- aplications
	term = "wezterm",
	editor = "wezterm -e " .. "nvim",
	code = "code",
	web = "firefox",
	music = "wezterm --class 'music' --config-file " .. home_var .. "/.config/alacritty/ncmpcpp.yml -e ncmpcpp ",
	files = "nautilus",

	-- your profile
	username = os.getenv("USER"),
	userdesc = "Theory will take you only so far",
}


local nice = require("nice")
nice {
	titlebar_color = "#0C0C0C",
	titlebar_items = {
		left = { "close", "minimize", "maximize" },
		middle = "title",
		right = {},
	},
	mb_contextmenu = nice.MB_MIDDLE,
	titlebar_font = "Iosevka 11",
	button_size = 14
}

-- theme 🖌️
require("theme")

-- configs ⚙️
require("config")

-- miscallenous ✨
require("misc")

-- signals 📶
require("signal")

-- ui elements 💻
require("layout")
