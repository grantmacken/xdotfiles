local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
wezterm.on('gui-startup', function()
 local tab, pane, window = mux.spawn_window({})
 window:gui_window():maximize()
end)

 -- https://git.anthonycicchetti.com/anthonycicc/dotfiles/commit/377019e759799760c9be78d22e8b40b1e9563792
-- Check whether the given file exists
--[[ function file_exists(name) ]]
--[[    local f = io.open(name, "r") ]]
--[[    if f ~= nil then io.close(f) return true else return false end ]]
--[[ end ]]

--[[ function wezterm_terminfo_installed() ]]
--[[   return file_exists(os.getenv('HOME') .. '/.terminfo/w/wezterm') ]]
--[[ end ]]
--[[ -- Determine what to set $TERM to ]]
--[[ function determine_term_value() ]]
--[[   if wezterm_terminfo_installed() then ]]
--[[     return 'wezterm' ]]
--[[   end ]]
--[[   return 'xterm-256color' ]]
--[[ end ]]
--[[]]
--[[ function ends_with(str, ending) ]]
--[[    return ending == "" or str:sub(-#ending) == ending ]]
--[[ end ]]

-- Query UI color on Gnome, see
-- https://wezfurlong.org/wezterm/config/lua/window/get_appearance.html
--[[ function query_appearance_gnome() ]]
--[[   local success, stdout = wezterm.run_child_process( ]]
--[[     {"gsettings", "get", "org.gnome.desktop.interface", "color-scheme"} ]]
--[[   ) ]]
--[[   stdout = stdout:lower():gsub("%s+", "") ]]
--[[   -- lowercase and remove whitespace ]]
--[[   if stdout == "'prefer-dark'" then ]]
--[[      return "Dark" ]]
--[[   end ]]
--[[   return "Light" ]]
--[[ end ]]

--[[ function scheme_for_appearance(appearance) ]]
--[[   if appearance:find("Dark") then ]]
--[[     return "Builtin Tango Dark" ]]
--[[   else ]]
--[[     return "Builtin Tango Light" ]]
--[[   end ]]
--[[ end ]]

-- Hook into right status polling to switch UI theme if the desktop theme
-- changed, see https://wezfurlong.org/wezterm/config/lua/window/get_appearance.html
--[[ wezterm.on("update-right-status", function(window, pane) ]]
--[[   local overrides = window:get_config_overrides() or {} ]]
--[[   local appearance = query_appearance_gnome() ]]
--[[   local scheme = scheme_for_appearance(appearance) ]]
--[[   if overrides.color_scheme ~= scheme then ]]
--[[     overrides.color_scheme = scheme ]]
--[[     window:set_config_overrides(overrides) ]]
--[[   end ]]
--[[ end) ]]
--[[]]
return {
  check_for_updates = false,
  -- term = determine_term_value(),
  font = wezterm.font("BlexMono Nerd Font Mono"),
  font_size = 14.0,
  line_height = 1.2,
  adjust_window_size_when_changing_font_size = false,
  font_antialias = "Subpixel",
  font_hinting = "Full",
  enable_wayland = true,
  unicode_version = 14,
  --force_reverse_video_cursor = true,
	colors = {
		foreground = "#dcd7ba",
		background = "#1f1f28",

		cursor_bg = "#c8c093",
		cursor_fg = "#c8c093",
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#16161d",

		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	},
inactive_pane_hsb = {
 saturation = 0.8,
 brightness = 0.7
},
  -- Tab Bar
  enable_tab_bar = true,
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  enable_scroll_bar = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  -- Don't beep
  audible_bell = 'Disabled',
  visual_bell = {
    fade_in_function = "EaseIn",
    fade_in_duration_ms = 150,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 150,
  },
use_dead_keys = false,
scrollback_lines = 5000,

}

