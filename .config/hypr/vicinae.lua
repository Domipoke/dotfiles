hl.layer_rule({
    match = {
      namespace = "vicinae"
    },
    ignore_alpha = 0,
    -- pin = true,
    blur = true,
    dim_around = true
  --focus_on_activate = true
})

hl.on("hyprland.start", function()
    hl.exec_cmd("vicinae server")
end)

hl.bind(mainMod .. " + Backslash", function ()
  hl.dispatch(hl.dsp.exec_cmd("vicinae toggle"))
end)
