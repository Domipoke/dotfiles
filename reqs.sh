FILE="$(pwd)/.config/hypr/config.lua"
if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' does not exist."
    echo "Go into dotfiles folder and run sh reqs.sh"
    exit 1
fi
#sudo pacman -S hyprland hyprpm nocatlia wl-clipboard polkit-gnome seahorse gnome-keyring hypridle dolphin satty kitty playerctl brightnessctl grim slurp --noconfirm

if ! command -v yay &>/dev/null; then
    echo "yay is not installed. Installing yay..."
    
    # Ensure prerequisites are installed
    sudo pacman -S --needed git base-devel
    
    # Clone and build yay in a temporary directory
    git clone https://aur.archlinux.org/yay.git /tmp/yay-build
    cd /tmp/yay-build || exit
    makepkg -si
    
    # Clean up and return to the original directory
    cd - > /dev/null || exit
    rm -rf /tmp/yay-build
    echo "yay installed successfully."
fi

#yay -S xwaylandvideobridge vicinae-bin
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

echo "Setup paths";
echo "DOTFILES_FOLDER = $(pwd)";
sed -i "s|DOTFILES_FOLDER = \".*\"|DOTFILES_FOLDER = \"$(pwd)\"|g" "$FILE"

while true; do
    read -p "Enter the name of the browser you want to use/install (e.g., firefox, brave-bin): " browser
    
    # Check if package exists in official Arch repos (pacman)
    if pacman -Si "$browser" &>/dev/null; then
        echo "Found '$browser' in official repositories. Installing..."
        sudo pacman -S "$browser"
        
        sed -i "s|Browser = \".*\"|Browser = \"$browser\"|g" "$FILE"
        echo "Config updated with Browser = \"$browser\"."
        break
        
    # Check if package exists in AUR (yay)
    elif command -v yay &>/dev/null && yay -Si "$browser" &>/dev/null; then
        echo "Found '$browser' in AUR. Installing..."
        yay -S "$browser"
        
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
            sudo pacman -S spotify
            break
            ;;
        [Nn]* ) 
            while true; do
                read -p "Do you use Spotube? (Spotube is an open source clone of Spotify that get tracks from youtube and other sites) (y/n): " choice
                case "$choice" in 
                    [Yy]* ) 
                        yay -S spotube
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

echo -e "\033[0;31mRemember to edit .config/hypr/monitors.lua monitor 'output' and 'mode'\033[0m"

