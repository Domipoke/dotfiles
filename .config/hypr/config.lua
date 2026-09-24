-- SIMPLE KEY MAPPING (index in lua starts from 1)
NUM_KEYS = {
  {code = "87"}, -- 1
  {code = "88"}, -- 2
  {code = "89"}, -- 3
  {code = "83"}, -- 4
  {code = "84"}, -- 5
  {code = "85"}, -- 6
  {code = "79"}, -- 7
  {code = "80"}, -- 8
  {code = "81"}, -- 9
  {code = "90"}  -- 0
}
-- Turn on/off features
NVIDIA_OPTIONS_ENABLED = true
PHONE_AS_DISPLAY = false

-- PATHS
HOME = "/home/domenico/"  
ICC = "/home/domenico/mnt/code/dotfiles/CalibrateDisplayProfile.icc" -- Emulates windows' color palette
hypr_folder = HOME .. ".config/hypr"
scripts_folder = hypr_folder .. "/scripts"
-- DEFAULT APPS
satty = HOME.."/.cargo/bin/satty --filename - --copy-command wl-copy --fullscreen --output-filename ~/Immagini/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"

Terminal = "kitty"
terminal_launch = "kitty bash -c " -- Space after -c is important

FileManager = "dolphin"
Browser = "vivaldi"
Editor = "code"
Spotify = "spotify"

Instagram="vivaldi --app-id=akpamiohjfcnimfljfndmaldlcfphjmp"
X="vivaldi --app-id=lodlkdfmihgonocnmddehnfgiljnadcf"
Whatsapp="vivaldi --app-id=hnpfjngllnobngcgfapefoaidbinmjnm"
Discord="vesktop"


