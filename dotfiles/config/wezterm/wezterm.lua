local wezterm = require 'wezterm';

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local HOURGLASS_ICON = utf8.char(0xf252)


local SUP_IDX = { "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹", "¹⁰",
  "¹¹", "¹²", "¹³", "¹⁴", "¹⁵", "¹⁶", "¹⁷", "¹⁸", "¹⁹", "²⁰" }
local SUB_IDX = { "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉", "₁₀",
  "₁₁", "₁₂", "₁₃", "₁₄", "₁₅", "₁₆", "₁₇", "₁₈", "₁₉", "₂₀" }


wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local edge_background = "#1e2029"
  local background = "#4E4E4E"
  local foreground = "#1C1B19"
  local dim_foreground = "#3A3A3A"

  if tab.is_active then
    background = "#FBB829"
    foreground = "#1C1B19"
  elseif hover then
    background = "#FF8700"
    foreground = "#1C1B19"
  end

  local edge_foreground = background
  local process_name = tab.active_pane.foreground_process_name
  local pane_title = tab.active_pane.title
  local exec_name = basename(process_name):gsub("%.exe$", "")
  local title_with_icon = HOURGLASS_ICON .. " " .. exec_name

  local left_arrow = SOLID_LEFT_ARROW
  if tab.tab_index == 0 then
    left_arrow = SOLID_LEFT_MOST
  end

  local id = SUB_IDX[tab.tab_index + 1]
  local pid = SUP_IDX[tab.active_pane.pane_index + 1]
  local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 6) .. " "

  return {
    { Attribute = { Intensity = "Bold" } },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = left_arrow },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = id },
    { Text = title },
    { Foreground = { Color = dim_foreground } },
    { Text = pid },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
    { Attribute = { Intensity = "Normal" } },
  }
end)

return {
  color_scheme = "MaterialDesignColors",
  font = wezterm.font 'SauceCodePro Nerd Font',
  font_size = 14.0,
  tab_max_width = 60,
  enable_scroll_bar = true,
  use_fancy_tab_bar = false,
  window_background_opacity = 0.8,
  colors = {
    tab_bar = {
      background = "#1e2029",
      new_tab = { bg_color = "#1e2029", fg_color = "#FCE8C3", intensity = "Bold" },
      new_tab_hover = { bg_color = "#1e2029", fg_color = "#FBB829", intensity = "Bold" },
      active_tab = { bg_color = "#1e2029", fg_color = "#FCE8C3" },
    }
  },
  ssh_domains = {
    {
      name = "devrel-ec2",
      remote_address = "3.129.61.227",
      ssh_option = {
        identityfile = "~/.ssh/devrelkp.pem",
      },
    },
  },
}
