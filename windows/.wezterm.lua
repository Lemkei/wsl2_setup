local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Default to WSL Ubuntu
config.default_domain = "WSL:Ubuntu-24.04"

-- Max performance rendering
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- Force Dx12 backend (Vulkan has rendering artifacts on AMD)
for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
  if gpu.backend == "Dx12" and gpu.device_type == "IntegratedGpu" then
    config.webgpu_preferred_adapter = gpu
    break
  end
end
config.max_fps = 90
config.animation_fps = 10
config.unicode_version = 14
config.normalize_output_to_unicode_nfc = true
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.enable_kitty_graphics = false
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0
config.use_ime = false  -- reduces keystroke latency (disable if you need CJK input)
config.underline_position = -2
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.tab_max_width = 40
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
  font_size = 10.0,
  active_titlebar_bg = "#111520",
  inactive_titlebar_bg = "#111520",
}
config.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }

-- Launch maximized
wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- Frieren Steel Blue (analogous to taskbar hue 221°, pink accents)
config.colors = {
  foreground = "#CDD6F4",
  background = "#161B26",
  cursor_fg = "#161B26",
  cursor_bg = "#CDD6F4",
  selection_fg = "none",
  selection_bg = "#3B4560",
  ansi = {
    "#2A3245", -- black (dark steel)
    "#CF7B98", -- red (rose pink — prompt color)
    "#A6E3A1", -- green
    "#6EBFC0", -- yellow (teal, from old Jubi)
    "#7A9DD6", -- blue (taskbar-matched)
    "#BC4F68", -- purple (deep rose)
    "#89B4FA", -- cyan (sky blue, matches wallpaper sky)
    "#BAC2DE", -- white
  },
  brights = {
    "#3B4D6B", -- bright black (steel blue mid)
    "#DE90AB", -- bright red (soft pink)
    "#BCDD61", -- bright green
    "#87E9EA", -- bright yellow (bright teal)
    "#A3C0F7", -- bright blue (sky color from wallpaper)
    "#E16C87", -- bright purple (bright rose)
    "#B7C9EF", -- bright cyan (light blue)
    "#D5E5F1", -- bright white
  },
  tab_bar = {
    background = "#111520",
    active_tab = {
      bg_color = "#7A9DD6",
      fg_color = "#111520",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#2A3245",
      fg_color = "#7A88A7",
    },
    inactive_tab_hover = {
      bg_color = "#3B4560",
      fg_color = "#CDD6F4",
    },
    new_tab = {
      bg_color = "#111520",
      fg_color = "#7A9DD6",
    },
    new_tab_hover = {
      bg_color = "#2A3245",
      fg_color = "#A3C0F7",
    },
  },
}

config.window_background_opacity = 1.0

config.background = {
  {
    source = { Color = "#253040" },
    width = "100%",
    height = "100%",
    opacity = 1.0,
  },
  {
    source = { File = "C:/Users/Lemke/Pictures/Screenshots/frieren_blur25.png" },
    width = "Cover",
    height = "Cover",
    opacity = 0.08,
    hsb = { brightness = 0.5, saturation = 1.0 },
    attachment = "Fixed",
  },
}

-- No copy on select, no formatting
config.selection_word_boundary = " \t\n{}[]()\"'`,;:@"

-- Font (adjust if you have a preference)
config.font_size = 11

-- Custom tab titles: show process + directory
wezterm.on("format-tab-title", function(tab)
  local pane = tab.active_pane
  local title = pane.title or ""
  local cwd = pane.current_working_dir

  -- Detect plain shell vs Claude Code (which sets titles like "Claude Code", plan names, etc.)
  local is_shell = title == "" or title == "wezterm" or title:find("bash") or title:find("zsh")

  if is_shell then
    if cwd then
      local dir = cwd.file_path or tostring(cwd)
      dir = dir:match("([^/]+)/?$") or dir
      title = "~ " .. dir
    else
      title = "Shell"
    end
  elseif cwd then
    -- Claude Code — show project folder with spinner prefix preserved
    local dir = cwd.file_path or tostring(cwd)
    dir = dir:match("([^/]+)/?$") or dir
    -- Extract leading spinner/status character (✳, ⠂, ⠐, etc.)
    local spinner = title:match("^(%S+)%s") or ""
    if spinner ~= "" then
      title = spinner .. " " .. dir
    else
      title = "Claude: " .. dir
    end
  end

  local index = tab.tab_index + 1
  return " " .. index .. ": " .. title .. " "
end)

-- Window title (what AW captures) — same logic as tab title
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
  local title = pane.title or ""
  local cwd = pane.current_working_dir
  local is_shell = title == "" or title == "wezterm" or title:find("bash") or title:find("zsh")

  if is_shell then
    if cwd then
      local dir = cwd.file_path or tostring(cwd)
      dir = dir:match("([^/]+)/?$") or dir
      return "~ " .. dir
    end
    return "Shell"
  elseif cwd then
    local dir = cwd.file_path or tostring(cwd)
    dir = dir:match("([^/]+)/?$") or dir
    return "Claude: " .. dir
  end
  return title
end)

-- Keybindings matching your Windows Terminal setup
config.keys = {
  -- Ctrl+Shift+C = copy
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
  -- Ctrl+Shift+V = paste
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
  -- Ctrl+Shift+F = search
  { key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },
  -- Alt+Shift+D = split pane
  { key = "d", mods = "ALT|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  -- Ctrl+V = paste from clipboard (image paste doesn't work in WSL2)
  { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
  -- Shift+Enter = send literal newline
  { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString('\n') },
}

return config
