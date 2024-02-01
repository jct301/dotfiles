local wezterm = require 'wezterm';
local act = wezterm.action
return {
  window_background_opacity = 0.95,
  font = wezterm.font({
    family="Iosevka NFM",
    harfbuzz_features={"calt=1", "clig=1", "liga=1"}
  }),
  font_size = 12,
  color_scheme = "Dracula (base16)",
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 20,
  },    
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    {key="c", mods="CTRL|ALT", action=act{CopyTo="ClipboardAndPrimarySelection"}},
    {key="v", mods="CTRL|ALT", action=act{PasteFrom="PrimarySelection"}},
    {key="t", mods="SHIFT|ALT", action=act{SpawnTab="CurrentPaneDomain"}},
    {key="%", mods="CTRL|SHIFT|ALT", action=act.SplitHorizontal{domain="CurrentPaneDomain"}},
  },
  mouse_bindings = {
    {event={Up={streak=1, button="Right"}}, mods="NONE", action=wezterm.action{PasteFrom="PrimarySelection"}},
  },
}
