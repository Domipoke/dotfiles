local reset = "reset"
local hub =  "Hub"

local social = "App" -- Now is S as "start"
local music = "Music"
local share = "Share"
local realme = "Realme"
local realme_move = "Realme Move"


hl.bind(mainMod .. " + code:" .. NUM_KEYS[10].code, hl.dsp.submap(hub), { description = "Select submap: "..hub })

hl.define_submap(hub, function ()
    hl.bind("S", hl.dsp.submap(social), { description = "Select submap: "..social})
    hl.bind("K", hl.dsp.submap(share), { description = "Select submap: "..share})
    hl.bind("M", hl.dsp.submap(music), { description = "Select submap: "..music})
    if PHONE_AS_DISPLAY then
      hl.bind("R", hl.dsp.submap(realme), { description = "Select submap: "..realme})
    end
    hl.bind("Escape", hl.dsp.submap(reset), { description = "Return to default submap" })
end)

-- Start

hl.define_submap(social, function ()
    hl.bind("I", function ()
      hl.dispatch(hl.dsp.exec_cmd(Instagram))
      hl.dispatch(hl.dsp.submap(reset))
    end, { description = social..": Run Instagram"})

    hl.bind("X", function ()
      hl.dispatch(hl.dsp.exec_cmd(X))
      hl.dispatch(hl.dsp.submap(reset))
    end, { description = social..": Run X" })

    hl.bind("D", function ()
      hl.dispatch(hl.dsp.exec_cmd(Discord))
      hl.dispatch(hl.dsp.submap(reset))
    end, { description = social..": Run Discord" })

    hl.bind("W", function ()
      hl.dispatch(hl.dsp.exec_cmd(Whatsapp))
      hl.dispatch(hl.dsp.submap(reset))
    end, { description = social..": Run WhatsApp"})

    hl.bind("S", function ()
      hl.dispatch(hl.dsp.exec_cmd(Spotify))
      hl.dispatch(hl.dsp.submap(reset))
    end, { description = social..": Run Spotify"})
    hl.bind("Escape", hl.dsp.submap(reset), { description = social..": Return to default submap" })
end)
if PHONE_AS_DISPLAY then
  hl.define_submap(realme, function ()
    hl.bind("M", hl.dsp.submap(realme_move), { description = "Select submap: "..realme_move })
  end)
end
if PHONE_AS_DISPLAY then
  hl.define_submap(realme_move, function ()
    for i = 1, 10 do
      local key = i % 10
      hl.bind(key, function ()
        hl.dispatch(hl.dsp.window.move({ workspace = (10+i) }))
        hl.dispatch(hl.dsp.submap(reset))
      end, { description = realme_move..": Move to "..(10+i).." workspace" })
    end
    hl.bind("Escape", hl.dsp.submap(reset), { description = realme_move..": Return to default submap" })
  end)
end
hl.define_submap(music, function ()
  hl.bind("S", function ()
    hl.dispatch(hl.dsp.exec_cmd(Spotify))
    hl.dispatch(hl.dsp.submap(reset))
  end, { description = music..": Run Spotify" })
end)

hl.define_submap(share, function ()
  hl.bind("L", function ()
    hl.dispatch(hl.dsp.exec_cmd("localsend"))
    hl.dispatch(hl.dsp.submap(reset))
  end, { description = share..": Run Localsend"})
end)
