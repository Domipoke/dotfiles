# HYPR
hypr is the default config folder for hyprland. 
This configuration can be considered as a fork of akiidjk's hyprland dotfiles with some month of my edits.

The core file is hyprland.lua which is the config file to which hyprland points to, by default his path is ~/.config/hypr/hyprland.lua.

In lua you can require another path by his relative path (only lua file can be required so no extension is needed), in order i call this files:
 - config: to manage variable value, software preferences and toggle some extra feature
 - monitors: to manage which display should me 
 - autostart: to run automatically some program
 - hyprcolors: setup colors, works with colors.lua and is a fallback for noctalia.lua
 - animation: setup animation
 - input: setup keyboard settings
 - keybinds: setup almost all shortcuts, exception for the feature only ones
 - windowrule: set how windows should be drawn
 - hub: is one of feature settings
 - vicinae: is the configuration of the vicinae launcher
 - noctalia: to use matugen with noctalia e some other feature.


# Explaination
After this section you will find a summary of what you should edit.

## Config
The config is diveded into some sections. The first one is simple key mapping for the numpad, in future could appear some other keys here. The second one is a boolean toggle for feature. 
 - NVIDIA_OPTIONS_ENABLED flag toggle the environments set for users who has like me a nvidia graphic card in their pc.
 - PHONE_AS_DISPLAY flag toggle the keybinds and monitors settings for use my phone as a second monitor. I put it to false because i do not use that now but i still don't want to delete from my configuration because who knows if a day i would use it again.
The third one is for PATHS, HOME is home path (~) but i prefer an absolute path to avoid bug and ICC is the location of the icc file here put in the git root directory. You can always choose to do not use ICC by set it to empty string ("").
The last one are default apps, i use social inside Progressive Web Apps vivaldi's feature (that's a common browser's feature) so to launch them i need to launch vivaldi (my browser) with a flag to identify the app. 

## Monitors
First block of monitors file is to set ICC configuration on main screen, that's for me called eDP-1 (this is the integrated screen of a laptop and should be the same for most hp's device, i have no clue if it is the same of any other device). 
mode define the widthxheight@framerate and should be edited according to your main monitor.
If you have more monitor you should add them even if they correctly turn on with no configuration to avoid unexpected behaviour after update. Main monitor is at position 0x0, the other should have an offset, for example if the first one is a 1920x1080, the second one is at position 1920x0 if set at right, just after the end of the first one.

```lua
for i = 1,10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
end
```
need to map the first ten workspace to the main monitor so shortcuts are locked on main monitor. For me this is the best setup for a laptop, but if you use a desktop pc maybe you prefer to divide the interval in something like:
```lua
for i = 1,5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
end
for i = 6,10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-1" })
end
```


# What should i edit?
1. Edit Config.lua
 - NVIDIA_OPTIONS_ENABLED
 - HOME
 - ICC
2. Edit monitors.lua
 - output in monitor
 - mode in monitor
 - monitor in workspace_rule