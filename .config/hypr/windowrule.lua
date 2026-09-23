local inFocusOpacity = "0.95"
local notInFocusOpacity = "0.85"



hl.window_rule({
    suppress_event = "maximize",
    match = {
        class = ".*"
    }
})

hl.window_rule({
    no_initial_focus = true,
    match = {
        class = "^$",
        title = "^$",
        xwayland = 1,
        float = 1,
        fullscreen = 0,
        pin = 0
    }
})
-- Noctalia
hl.window_rule({
    opacity = "1",
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})

hl.layer_rule({
  name = "noctalia",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
  },
  no_anim = true,
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})

-- END Noctalia
hl.window_rule({
    opacity = inFocusOpacity .. " " .. notInFocusOpacity,
    match = { title = "^.*().*$" }
})

hl.window_rule({
    opacity = "0.80",
    float = true,
    size = { 600, 400 },
    match = { class = "^(nwg-displays)$" }
})

hl.window_rule({
    opacity = 0.80,
    float = true,
    size = { 600, 400 },
    match = { class = "^(blueman-manager)$" }
})

hl.window_rule({
    opacity = 0.80,
    float = true,
    size = { 600, 400 },
    match = { class = "^(org.pulseaudio.pavucontrol)$" }
})


-- xwaylandvideobridge
hl.window_rule({
    opacity = "0.0 override",
    no_anim = 1,
    no_initial_focus = 1,
    no_focus = 1,
    max_size = { 1, 1 },
    no_blur = 1,
    match = { class = "^(xwaylandvideobridge)$" }
})



-- Picture in Picture
hl.window_rule({
    float = true,
    tile = false,
    opacity = "1.0",
    pin = true,
    match = {
        title = "(Picture in picture)|(Discord Popout)"
    }
})


-- Spotify mini player
hl.window_rule({
    float = true,
    tile = false,
    opacity = "1.0 0.75",
    size={419, 56},
    move={1482, 1006},
    pin = true,
    match = {
        workspace = "special:music",
        class="Chromium-browser",
    }
})

hl.window_rule({
  opacity = "1.0",
  match = {
    class = "vlc"
  }
})


-- fullscreen App
hl.window_rule({
    opacity = "1.0",
    fullscreen = true,
    match = {
        class ="blender"
    }
})

hl.window_rule({
  opacity = "1.0",
  float = true,
  focus_on_activate = true,
  match = { class = "org.kde.ksecretd|gcr-prompter"}
})

-- Floating terminal
-- hl.window_rule({
--     opacity = "0.75 0.25",
--     no_blur = true,
--     float = true,
--     pin = true,
--     match = {class = "kitty", title = "Floating"},
--     size = {430, 414},
--     move = {"(cursor_x - (window_w*0.5))", "(cursor_y-(window_h*0.5))"}
-- })

hl.window_rule({
  opacity = 1,
  match = {class = "scrcpy"}
})

hl.window_rule({opacity = 1, match = {title = "Mindustry"}})
hl.window_rule({opacity=1, match = {title = "Minecraft 26.2"}})
