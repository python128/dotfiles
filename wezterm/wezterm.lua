math.randomseed(os.time())

local hue = math.random(0, 360);

local wezterm = require 'wezterm'

local function font_with_fallback(name, params)
  local names = { name, "Noto Color Emoji", "FiraCode Nerd Font" }
  return wezterm.font_with_fallback(names, params)
end

-- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

local Grey = "#0f1419"
local LightGrey = "#191f26"

local TAB_BAR_BG = "Black"
local ACTIVE_TAB_BG = "#dcff00"
local ACTIVE_TAB_FG = "Black"
local HOVER_TAB_BG = Grey
local HOVER_TAB_FG = "White"
local NORMAL_TAB_BG = LightGrey
local NORMAL_TAB_FG = "White"

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local background = NORMAL_TAB_BG
  local foreground = NORMAL_TAB_FG

  local is_first = tab.tab_id == tabs[1].tab_id
  local is_last = tab.tab_id == tabs[#tabs].tab_id

  if tab.is_active then
    background = ACTIVE_TAB_BG
    foreground = ACTIVE_TAB_FG
  elseif hover then
    background = HOVER_TAB_BG
    foreground = HOVER_TAB_FG
  end

  local leading_fg = NORMAL_TAB_FG
  local leading_bg = background

  local trailing_fg = background
  local trailing_bg = NORMAL_TAB_BG

  if is_first then
    -- leading_fg = TAB_BAR_BG
    leading_fg = background
    leading_bg = background
  else
    leading_fg = NORMAL_TAB_BG
  end

  if is_last then
    trailing_bg = TAB_BAR_BG
  else
    trailing_bg = NORMAL_TAB_BG
  end

  local title = tab.active_pane.title 
  -- broken?
  -- local title = " " .. wezterm.truncate_to_width(tab.active_pane.title, 30) .. " "

  return {
    {Attribute={Italic=false}},
    {Attribute={Intensity=hover and "Bold" or "Normal"}},
    {Background={Color=leading_bg}},  {Foreground={Color=leading_fg}},
    {Text=SOLID_RIGHT_ARROW},
    {Background={Color=background}},  {Foreground={Color=foreground}},
    {Text=" "..title.." "},
    {Background={Color=trailing_bg}}, {Foreground={Color=trailing_fg}},
    {Text=SOLID_RIGHT_ARROW},
  }
end)

wezterm.on("update-right-status", function(window, pane)
  local leader = ""
  if window:leader_is_active() then
    leader = " ⚠️ 🔴 ⚠️  "
  end
    window:set_right_status(leader)
end);


return {
  -- default_prog = {"wsl", "-d", "Ubuntu-20.04"},
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBlock",
  -- native_macos_fullscreen_mode = true,

  -- hide_tab_bar_if_only_one_tab = true,
  -- tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  tab_max_width = 32,
  
  initial_cols = 130,
  initial_rows = 80,

  inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.5,
  },

  -- color_scheme = "3024 Day",
  colors = {
    tab_bar = {
      background = TAB_BAR_BG,
    },
    compose_cursor = "orange",
  },

  tab_bar_style = {
    new_tab = wezterm.format{
      {Background={Color=HOVER_TAB_BG}}, {Foreground={Color=TAB_BAR_BG}},
      {Text=SOLID_RIGHT_ARROW},
      {Background={Color=HOVER_TAB_BG}}, {Foreground={Color=HOVER_TAB_FG}},
      {Text=" + "},
      {Background={Color=TAB_BAR_BG}}, {Foreground={Color=HOVER_TAB_BG}},
      {Text=SOLID_RIGHT_ARROW},
    },
    new_tab_hover = wezterm.format{
      {Attribute={Italic=false}},
      {Attribute={Intensity="Bold"}},
      {Background={Color=NORMAL_TAB_BG}}, {Foreground={Color=TAB_BAR_BG}},
      {Text=SOLID_RIGHT_ARROW},
      {Background={Color=NORMAL_TAB_BG}}, {Foreground={Color=NORMAL_TAB_FG}},
      {Text=" + "},
      {Background={Color=TAB_BAR_BG}}, {Foreground={Color=NORMAL_TAB_BG}},
      {Text=SOLID_RIGHT_ARROW},
    },
  },

  exit_behavior = "Close",
  leader = { key="a", mods="CTRL", timeout_milliseconds=1000 },
  keys = {
    -- { key = "`",  mods = "LEADER",       action="ShowLauncher"},
    -- { key = "a",  mods = "LEADER|CTRL",  action=wezterm.action{SendString="\x01"}},
    -- { key = "c",  mods = "LEADER",       action=wezterm.action{SpawnTab="DefaultDomain"}},
    -- { key = "-",  mods = "LEADER",       action=wezterm.action{ SplitVertical={ domain="CurrentPaneDomain" } } },
    -- { key = "\\", mods = "LEADER",       action=wezterm.action{ SplitHorizontal={ domain="CurrentPaneDomain" } } },
    -- { key = "h",  mods = "LEADER",       action=wezterm.action{ ActivatePaneDirection="Left" } },
    -- { key = "l",  mods = "LEADER",       action=wezterm.action{ ActivatePaneDirection="Right" } },
    -- { key = "j",  mods = "LEADER",       action=wezterm.action{ ActivatePaneDirection="Down" } },
    -- { key = "k",  mods = "LEADER",       action=wezterm.action{ ActivatePaneDirection="Up" } },
    -- { key = "{",  mods = "SHIFT|ALT",    action=wezterm.action{ MoveTabRelative=-1 } },
    -- { key = "}",  mods = "SHIFT|ALT",    action=wezterm.action{ MoveTabRelative=1 } },
    -- { key = "d",  mods = "LEADER", action=wezterm.action{CloseCurrentTab={confirm=false}}},
    -- { key = "x",  mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},

    {key="c", mods="LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="d", mods="LEADER", action=wezterm.action{CloseCurrentTab={confirm=false}}},
    {key="1", mods="LEADER", action=wezterm.action{ActivateTab=0}},
    {key="2", mods="LEADER", action=wezterm.action{ActivateTab=1}},
    {key="3", mods="LEADER", action=wezterm.action{ActivateTab=2}},
    {key="4", mods="LEADER", action=wezterm.action{ActivateTab=3}},
    {key="5", mods="LEADER", action=wezterm.action{ActivateTab=4}},
    {key="6", mods="LEADER", action=wezterm.action{ActivateTab=5}},
    {key="7", mods="LEADER", action=wezterm.action{ActivateTab=6}},
    {key="8", mods="LEADER", action=wezterm.action{ActivateTab=7}},
    {key="LeftArrow", mods="CTRL", action=wezterm.action{SendString="\x1bb"}},
    {key="RightArrow", mods="CTRL", action=wezterm.action{SendString="\x1bf"}},
    {key="Backspace", mods="CTRL", action={
      Multiple={
        {SendKey={key="Escape"}},
        {SendKey={key="Backspace"}},
        }}},
  },

  ssh_domains = {
    {
      -- This name identifies the domain
      name = "ubuntu",
      -- The address to connect to
      remote_address = "localhost",
      -- The username to use on the remote host
      username = "nexinov",
    }
  },
  default_gui_startup_args = {"connect", "ubuntu"},
  font = font_with_fallback("Hack"),
  font_size = 12.0,
  -- font = font_with_fallback("FiraCode Nerd Font"),

  -- font_rules = {
  --   { -- BOLD
  --     intensity = "Bold",
  --     weight = "Bold",
  --     font = font_with_fallback("FiraCode Nerd Font", { weight = "Bold" }),
  --   },

  --   { -- ITALIC
  --     italic = true,
  --     weight = "Light",
  --     font = font_with_fallback("Operator Mono SSm Lig", { italic = true }),
  --   },

  --   { -- BOLD ITALIC
  --     italic = true,
  --     intensity = "Bold",
  --     weight = "Book",
  --     font = font_with_fallback("Operator Mono SSm Lig", { weight = "Bold", italic = true }),
  --   },

  --   { -- LIGHT
  --     intensity = "Half",
  --     weight = "Light",
  --     font = font_with_fallback("Operator Mono SSm Lig"),
  --   },
  -- },
  -- window_background_gradient = {
  --   colors = {
  --     "#302b63",
  --     "#0f0c29",
  --   },
  --   orientation = {
  --     Radial={
  --       cx = 0.5,
  --       cy = 0.5,
  --       radius = 0.65,
  --     }
  --   },
  -- },
  window_background_gradient = {
    colors = {string.format("hwb(%f,%f%%,90%%)", hue, math.random(45, 50)), string.format("hwb(%f,0%%,%f%%)", hue, math.random(90, 100))},
    blend = "Oklab",
    orientation = {
      Radial = {
        cx = 0.9,
        cy = 0.2,
        radius = 1.3, 
      }
    },
  }
}
