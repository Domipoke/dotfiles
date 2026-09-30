if [ "$EUID" -eq 0 ]; then
    echo "Error: Please do not run this script with sudo."
    echo "It will prompt for your password here when it hits the sudo command"
    exit 1
fi

FILE="$(pwd)/.config/hypr/config.lua"
installer_flags="--needed --noconfirm"
flagDesc="--needed check if already installed and skip it" 
flagDesc="--noconfirm disable the prompt of y/n, need to install so the response is yes always. This script asks confirm when it has to install optional addon." 
echo "This installer run pacman and yay installation with the following flags: "
echo $installer_flags
echo $flagDesc

# ╭───────────────────────────────────────────────────────────────────
# │ START: Check if in the right folder
# ╰───────────────────────────────────────────────────────────────────

if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' does not exist."
    echo "Go into dotfiles folder and run sh reqs.sh"
    exit 1
fi


# ╭───────────────────────────────────────────────────────────────────
# │ END: Check if in the right folder
# ╰───────────────────────────────────────────────────────────────────

# ╭───────────────────────────────────────────────────────────────────
# │ START: Global needed pacman and yay
# ╰───────────────────────────────────────────────────────────────────
sudo pacman -S hyprland hyprpm nocatlia wl-clipboard polkit-gnome seahorse gnome-keyring hypridle dolphin satty kitty playerctl brightnessctl grim slurp $installer_flags

if ! command -v yay &>/dev/null; then
    echo "yay is not installed. Installing yay..."
    
    # Ensure prerequisites are installed
    sudo pacman -S --needed git base-devel $installer_flags 
    
    # Clone and build yay in a temporary directory
    git clone https://aur.archlinux.org/yay.git /tmp/yay-build
    cd /tmp/yay-build || exit
    makepkg -si
    
    # Clean up and return to the original directory
    cd - > /dev/null || exit
    rm -rf /tmp/yay-build
    echo "yay installed successfully."
fi

yay -S xwaylandvideobridge vicinae-bin $installer_flags


# ╭───────────────────────────────────────────────────────────────────
# │ END: Global needed pacman and yay
# ╰───────────────────────────────────────────────────────────────────
# ╭───────────────────────────────────────────────────────────────────
# │ START: Nvidia
# ╰───────────────────────────────────────────────────────────────────

while true; do
    read -p "Enable NVIDIA options? (y/n): " choice
    case "$choice" in 
        [Yy]* ) 
            sed -i 's/NVIDIA_OPTIONS_ENABLED = false/NVIDIA_OPTIONS_ENABLED = true/g' "$FILE"
            break
            ;;
        [Nn]* ) 
            sed -i 's/NVIDIA_OPTIONS_ENABLED = true/NVIDIA_OPTIONS_ENABLED = false/g' "$FILE"
            break
            ;;
        * ) 
            echo "Invalid input. Please answer y or n."
            ;;
    esac
done

# ╭───────────────────────────────────────────────────────────────────
# │ END: Nvidia
# ╰───────────────────────────────────────────────────────────────────

# ╭───────────────────────────────────────────────────────────────────
# │ START: Edits on Config and other optional installations
# ╰───────────────────────────────────────────────────────────────────
echo "Setup paths";
echo "DOTFILES_FOLDER = $(pwd)";
sed -i "s|DOTFILES_FOLDER = \".*\"|DOTFILES_FOLDER = \"$(pwd)\"|g" "$FILE"

while true; do
    read -p "Enter the name of the browser you want to use/install (e.g., firefox, brave-bin): " browser
    
    # Check if package exists in official Arch repos (pacman)
    if pacman -Si "$browser" &>/dev/null; then
        echo "Found '$browser' in official repositories. Installing..."
        sudo pacman -S "$browser" $installer_flags
        
        sed -i "s|Browser = \".*\"|Browser = \"$browser\"|g" "$FILE"
        echo "Config updated with Browser = \"$browser\"."
        break
        
    # Check if package exists in AUR (yay)
    elif command -v yay &>/dev/null && yay -Si "$browser" &>/dev/null; then
        echo "Found '$browser' in AUR. Installing..."
        yay -S "$browser" $installer_flags
        
        sed -i "s|Browser = \".*\"|Browser = \"$browser\"|g" "$FILE"
        echo "Config updated with Browser = \"$browser\"."
        break
    else
        echo "Error: Package '$browser' could not be found via pacman or yay. Please try again."
    fi
done

yay -S visual-studio-code-bin

while true; do
    read -p "Do you use Spotify? (y/n): " choice
    case "$choice" in 
        [Yy]* ) 
            sudo pacman -S spotify $installer_flags
            break
            ;;
        [Nn]* ) 
            while true; do
                read -p "Do you use Spotube? (Spotube is an open source clone of Spotify that get tracks from youtube and other sites) (y/n): " choice
                case "$choice" in 
                    [Yy]* ) 
                        yay -S spotube $installer_flags
                        break
                        ;;
                    [Nn]* ) 
                        sed -i "s|Browser = \".*\"|Browser = \"spotube\"|g" "$FILE"
                        break
                        ;;
                    * ) 
                        echo "Invalid input. Please answer y or n."
                        ;;
                esac
            done

            break
            ;;
        * ) 
            echo "Invalid input. Please answer y or n."
            ;;
    esac
done

# ╭───────────────────────────────────────────────────────────────────
# │ END: Edits on Config and other optional installations
# ╰───────────────────────────────────────────────────────────────────

# ╭───────────────────────────────────────────────────────────────────
# │ START: Other suggestions
# ╰───────────────────────────────────────────────────────────────────
while true; do
    read -p "Do you want to use fish as shell? (y/n): " choice
    case "$choice" in 
        [Yy]* ) 
            sudo pacman -S fish $installer_flags
            chsh -s /usr/bin/fish
            break
            ;;
        [Nn]* ) 
            break
            ;;
        * ) 
            echo "Invalid input. Please answer y or n."
            ;;
    esac
done
sudo pacman -S ttf-jetbrains-mono-nerd ttf-firacode-nerd ttf-firacode-nerd $installer_flags

while true; do
    read -p "Do you want to install vlc? (y/n): " choice
    case "$choice" in 
        [Yy]* ) 
            sudo pacman -S vlc $installer_flags
            break
            ;;
        [Nn]* ) 
            break
            ;;
        * ) 
            echo "Invalid input. Please answer y or n."
            ;;
    esac
done

while true; do
    read -p "Do you want to install zathura? (Zathura is light pdf reader which supports extensions) (y/n): " choice
    case "$choice" in 
        [Yy]* ) 
            sudo pacman -S zathura zathura-djvu zathura-cb zathura-pdf-mupdf $installer_flags
            break
            ;;
        [Nn]* ) 
            break
            ;;
        * ) 
            echo "Invalid input. Please answer y or n."
            ;;
    esac
done

# ╭───────────────────────────────────────────────────────────────────
# │ END: Other suggestions
# ╰───────────────────────────────────────────────────────────────────

# ╭───────────────────────────────────────────────────────────────────
# │ START: What to do now?
# ╰───────────────────────────────────────────────────────────────────

echo "What to do now?"
echo -e "\033[0;31mEdit .config/hypr/monitors.lua monitor 'output' and 'mode'\033[0m"
echo "kitty +kitten themes"

# ╭───────────────────────────────────────────────────────────────────
# │ END: What to do now?
# ╰───────────────────────────────────────────────────────────────────