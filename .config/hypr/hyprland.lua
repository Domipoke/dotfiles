require("config")
require("privatesettings")

-- Setup gestures
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
-- Some config
hl.config({
    dwindle = {
        -- force_split    = 0,
        preserve_split = true,
        -- smart_split                  = false,
        -- smart_resizing               = true,
        -- permanent_direction_override = false,
        -- special_scale_factor         = 1,
        -- split_width_multiplier       = 1.0,
        -- use_active_for_splits        = true,
        -- default_split_ratio          = 1.0,
        -- split_bias                   = 0,
        -- precise_mouse_move           = false,
    },
})

-- Load monitors config
require("monitors")

-- Nvidia settings
hl.env("LIBVA_DRIVER_NAME.nvidia", "true")
hl.env("__GLX_VENDOR_LIBRARY_NAME.nvidia", "true")

require("autostart")


-- #############################
-- ### ENVIRONMENT VARIABLES ###
-- #############################

--    # See https://wiki.hyprland.org/Configuring/Environment-variables/
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("XDG_MENU_PREFIX","arch- kbuildsycoca6")

-- # 01-xdg-base.conf
--hl.env("XDG_CONFIG_HOME", "/home/domenico/.config")
--hl.env("XDG_DATA_HOME", "/home/domenico/.local/share")
--hl.env("XDG_CACHE_HOME", "/home/domenco/.cache")
--hl.env("XDG_STATE_HOME", "/home/domenico/.local/state")

--hl.env("XDG_DATA_DIRS", "/home/domenico/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share")

-- # 10-kde-on-niri/hyprland

--hl.env("QT_QPA_PLATFORM", "wayland")

-- # REQUIRED: make sure portal uses KDE Qt platform theme
--hl.env("QT_QPA_PLATFORMTHEME","kde")
--hl.env("QT_QPA_PLATFORMTHEME_QT6","kde")

-- # REQUIRED: helps fixing Dolphin default applications issue
--hl.env("XDG_MENU_PREFIX","plasma-")

--hl.env("QT_AUTO_SCREEN_SCALE_FACTOR","1")
--hl.env("QT_ENABLE_HIGHDPI_SCALING","1")
--hl.env("QT_SCALE_FACTOR_ROUNDING_POLICY","RoundPreferFloor")

-- 80-gtk-no-btn.conf
--hl.env("GTK_DECORATION_LAYOUT","")

-- 99-electron.conf
--hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- #####################
-- ### LOOK AND FEEL ###
-- #####################
require("hyprcolors")
require("animation")

hl.config({
    misc = {
        force_default_wallpaper = -1, --  # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true  --  # If true disables the random hyprland logo / anime girl background. :(
    }
})


-- #############
-- ### INPUT ###
-- #############
require("input")
require("keybinds")

-- ##############################
-- ### WINDOWS AND WORKSPACES ###
-- ##############################
-- # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
-- # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules
require("windowrule")
require("workspace")



-- ###########
-- ### HUB ###
-- ###########
require("hub")


-- ##################
-- ### EXTENSIONS ###
-- ##################
require("vicinae")


-- For Noctalia Color templates
require("noctalia").apply_theme()
