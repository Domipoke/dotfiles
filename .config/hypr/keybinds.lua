

--noctalia = "qs -c noctalia-shell ipc call "
noctalia = "noctalia msg "
mainMod = "SUPER"

-- Exec
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(Terminal), { description = "Open terminal" })
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(Terminal, {
    opacity = "0.75 0.25",
    no_blur = true,
    float = true,
    pin = true,
    size = {450, 450},
    move = {"(cursor_x-(450*0.5))", "(cursor_y-(450*0.5))"}
}), {description = "Open a floating terminal"})
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal_launch.."yazi"), { description = "Open file manager" })
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(FileManager), {description = "Open file manager"})
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(Browser), { description = "Open browser" })
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(Editor), { description = "Open editor" })
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(noctalia .. "panel-toggle clipboard"), {description = "Open Clipboard history"})
hl.bind("ALT + L", hl.dsp.exec_cmd("hyprlock --grace 5"), { description = "Lock screen" })

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/hyprPicker.sh"), { description = "Color picker" })

-- WM Control binds
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Close window" })
hl.bind(mainMod .. " + CTRL + SHIFT + Q", hl.dsp.exit(), { description = "Exit WM" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1, internal = 0, client = 2 }),
    { description = "Maximize window" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 0, internal = 0, client = 2 }),
    { description = "Fullscreen window" })
hl.bind(mainMod .. " + T", hl.dsp.window.float(), { description = "Toggle floating" })
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle split" })
hl.bind(mainMod .. " + G", hl.dsp.layout("swapsplit"), { description = "Swap split" })
hl.bind(mainMod .. " + P", hl.dsp.window.pin(), { description = "Pin a window"})

-- Window Switch
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ direction = "down" }), { description = "Focus down" })

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = key }), { description = "Focus workspace " .. key })
    hl.bind(mainMod .. " + SHIFT +" .. key, hl.dsp.window.move({ workspace = key }),
        { description = "Move to workspace " .. key })
end

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "previous" }), { description = "Focus previous workspace" })
hl.bind(mainMod .. " + left", hl.dsp.focus({ workspace = "-1" }), { description = "Focus left workspace" })
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "-1" }))

hl.bind(mainMod .. " + right", hl.dsp.focus({ workspace = "+1" }), { description = "Focus right workspace" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "+1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

hl.bind(mainMod .. " + CTRL + SHIFT + left", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { description = "Resize window left" })
hl.bind(mainMod .. " + CTRL + SHIFT + right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { description = "Resize window right" })
hl.bind(mainMod .. " + CTRL + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { description = "Resize window up" })
hl.bind(mainMod .. " + CTRL + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { description = "Resize window down" })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, description = "Raise volume" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, description = "Lower volume" })

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true, description = "Toggle mute" })
hl.bind("SHIFT + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true, description = "Toggle mic mute" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"), { repeating = true, description = "Raise brightness" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { repeating = true, description = "Lower brightness" })

-- Screenshot a window
local copy = "wl-copy"
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -t png -g "$(slurp)" - | ' .. copy), { description = "Screenshot region" })
hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.exec_cmd('grim -t png -g "$(slurp)" - | ' .. satty), { description = "Screenshot and edit"})
hl.bind("PRINT", hl.dsp.exec_cmd('grim - | ' .. copy), { description = "Fullscreen Screenshots"})
-- Night mode and ToggleMirror scripts
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/toggleMirror.sh"), { description = "Toggle mirror" })
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("bash " .. scripts_folder .. "/nightmode.sh"), { description = "Toggle night mode" })



-- Noctalia shortcut
--hl.bind(mainMod .. " + Backslash", hl.dsp.exec_cmd(noctalia .. "panel-toggle launcher"), { description = "Toggle quickshell bar" })
--hl.bind(mainMod .. " + Backslash", hl.dsp.exec_cmd("vicinae toggle"), { description = "Toggle Vicinae" })
hl.bind("ALT + Tab", hl.dsp.exec_cmd(noctalia .. "window-switcher"), { description = "Switch between windows" })
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(noctalia .. "notification-dnd-toggle"), { description = "Toggle Do Not Disturb" })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(noctalia .. "panel-toggle control-center notifications"), { description = "Open notifications" })
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(noctalia .. "panel-toggle wallpaper"), { description = "Change wallpaper" })
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(noctalia .. "panel-toggle noctalia/wallhaven:browser"), { description = "Toggle WallHaven" })
