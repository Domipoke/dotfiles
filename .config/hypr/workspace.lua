local music_workspace = "Music"
local voicechat_workspace = "Voice"
local obs_workspace = "obs"
local social_workspace = "Social"
local search_workspace = "Search"

-- Keybinds that define workspaces
--hl.bind(mainMod .. " + code:"..NUM_KEYS[4].code, hl.dsp.workspace.toggle_special(search_workspace))
hl.bind(mainMod .. " + code:"..NUM_KEYS[5].code, hl.dsp.workspace.toggle_special(social_workspace))
hl.bind(mainMod .. " + code:"..NUM_KEYS[7].code, hl.dsp.workspace.toggle_special(music_workspace))
hl.bind(mainMod .. " + code:"..NUM_KEYS[8].code, hl.dsp.workspace.toggle_special(voicechat_workspace))
hl.bind(mainMod .. " + code:"..NUM_KEYS[9].code, hl.dsp.workspace.toggle_special(obs_workspace))

hl.window_rule({
  name = "discord",
  match = {class = "^(discord|vesktop)$"},
  workspace = "special:" .. voicechat_workspace
})

hl.window_rule({
  name = "spotify",
  match = {class = "^(Spotify)$"},
  workspace = "special:" .. music_workspace 
})

hl.window_rule({
  name = "obs",
  match = {class = "com.obsproject.Studio"},
  workspace = "special:" .. obs_workspace 
})

hl.window_rule({
  name = "Social installed with vivaldi",
  match = {title = "WhatsApp Web|X|Instagram"},
  workspace = "special:" .. social_workspace
})

hl.window_rule({
  name = "telegram",
  match = {class = "org.telegram.desktop"},
  workspace = "special:" .. social_workspace
})

--hl.window_rule({
--  name = "vivaldi",
--  match = {class = "vivaldi-stable"},
--  workspace = "1"
--})
