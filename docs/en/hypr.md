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

## Autostart

The event hyprland.start group all the commands that should run on start. In order they are

- wl-paste and wl-clip-persist to allow us to copy and paste anything we want
- starts service hyprpolkit as "ask for sudo password" menu
- hypridle manage hyprland behaviour on idle
- screen sharing settings to avoid bug
- Bluetooth section is commented because noctalia provide all I need
- Keyboard settings was needed with kde5 but not with kde6 which i have now
- hyprpm manage the hyprland plugins
- kde6 and kbuildsycoca6 are package to fix color palette for kde based application like dolphin
- lastly run noctalia
- (vicinae is runned by vicinae.lua file, also that one on start)

## Hyprcolors

hyprcolors setup gaps between apps and border size, rounding corner, shadows and blur. All information are avaible on the official documentation: https://wiki.hyprland.org/Configuring/Variables/

## Animation

Are copied from akiidjk. All information are avaible on the official documentation: https://wiki.hypr.land/configuring/core/animations/

## Input

This are keyboard settings, kb_layout is defined buy the language's initials

## Keybinds

noctalia is the base command to run shell feature. mainMod is the key to press to run any of the main keybinds, i use SUPER that is my windows key.

### Fast run

SUPER + RETURN run Terminal which is in config.lua set to kitty.
SUPER + SHIFT + RETURN run Terminal in a floating mode (I use it when i need a terminal while I'm watching something. It spawn near the cursor)

SUPER + E run yazi (a tui explorer manager)
SUPER + D run dolphin (kde explore manager)

SUPER + B run browser (for me vivaldi)
SUPER + C run Editor (for me code)

SUPER + V toggle clipboard history panel; noctalia v4 had a better plugin.

### Utility

ALT + L to lock pc, hyprland lock also on lid close
SUPER + SHIFT + C is a color picker

### Hyprland keys

SUPER + Q close the current window
SUPER + CTRL + SHIFT + Q shut down window manager (just for emergency)
SUPER + F toggle selected window's full width view. (works when more windows are opened on same workspace)
SUPER + SHIFT + F toggle selected window's fullscreen.
SUPER + T toggle selected window's floating view
SUPER + J switch between vertical and horizzontal divided
SUPER + G swap two window in the same workspace
SUPER + P pin a window on all workspace
SUPER + SHIFT + M Toggle nightmode (need a script)

### Workspaces

#### Move between windows

SUPER + CTRL + ArrowKey focus the window on the side of the pressed arrow key.

#### Move between workspaces

SUPER + num Focus num+1 workspace (1-10)
SUPER + Tab Focus previous workspace
SUPER + Left/Right Focus current-1/current+1 workspace
ALT + TAB Open the window switcher

#### Move a window to workspace

SUPER + SHIFT + num Move the selected window to num+1 workspace (1-10)
SUPER + SHIFT + Left/Right Move the selected window to current-1/current+1 workspace

#### Window's Actions

SUPER + mouse:272 (Left Click) Drag window
SUPER + mouse:273 (Right Click) Resize window (works only on float windows or if there are more then one window in a workspace)
SUPER + CTRL + SHIFT + ArrowKey Resize window

### Fn Keys

Fn Keys are captured on hyprland as their id. Ids can be found on documentation at: https://wiki.hypr.land/configuring/core/binds/
You can use software like wev to know how a button is called.
I set keys for volume, control player and control brightness

### Screenshot

For screenshots i use three different configuration as you can see.
SUPER + SHIFT + S use grim (slurp) -> copy
SUPER + CTRL + SHIFT + S grim (slurp) -> satty
PRINT (or STAMP) grim -> copy

#### Tools Explaination

grim is the tool that take the screenshot. flags are -t png to define that is an image and -g $(slurp) to define the section.
slurp is a tool that obtain a section of the screen in a format "x,y widthxheight".
copy is a variable, in my case equal to wl-copy (as default for hyprland) and identify the tool need to copy in clipboard.
satty is a tool to edit image adding lines, arrows, highlights and other stuff.

### Noctalia
SUPER + N Toggle Notifications
SUPER + SHIFT + N Toggle Do Not Disturb
SUPER + W Toggle Wallpapers
SUPER + SHIFT + W toggle wallhave (need noctalia/wallhaven plugin installed)

## WindowsRule

# What should i edit?

1. Edit Config.lua

- NVIDIA_OPTIONS_ENABLED
- HOME
- ICC
- hypr_folder 
- scripts_folder (if changed)
- satty
- all other favourites apps

2. Edit monitors.lua

- output in monitor
- mode in monitor
- monitor in workspace_rule

3. Edit input.lua

- kb_layout
