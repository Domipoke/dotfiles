outputcolor="\033[1;34m"

print () {
    echo -e "\033[1;34m$1\033[0m"
}
print_error () {
    echo -e "\033[1;31m$1\033[0m"
}
if [ "$EUID" -eq 0 ]; then
    print "Error: Please do not run this script with sudo."
    print "It will prompt for your password here when it hits the sudo command"
    exit 1
fi
FILE="$(pwd)/.config/hypr/config.lua"
installer_flags="--needed --noconfirm"
flagDesc="--needed check if already installed and skip it" 
flagDesc="--noconfirm disable the prompt of y/n, need to install so the response is yes always. This script asks confirm when it has to install optional addon." 
print "This installer run pacman and yay installation with the following flags: "
print $installer_flags
print $flagDesc

# ╭───────────────────────────────────────────────────────────────────
# │ START: Check if in the right folder
# ╰───────────────────────────────────────────────────────────────────

if [ ! -f "$FILE" ]; then
    print "Error: File '$FILE' does not exist."
    print "Go into dotfiles folder and run sh reqs.sh"
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
    print "yay is not installed. Installing yay..."
    
    # Ensure prerequisites are installed
    sudo pacman -S --needed git base-devel $installer_flags 
    
    # Clone and build yay in a temporary directory
    git clone https://aur.archlinux.org/yay.git /tmp/yay-build
    cd /tmp/yay-build || exit
    makepkg -si
    
    # Clean up and return to the original directory
    cd - > /dev/null || exit
    rm -rf /tmp/yay-build
    print "yay installed successfully."
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
            print "Invalid input. Please answer y or n."
            ;;
    esac
done

# ╭───────────────────────────────────────────────────────────────────
# │ END: Nvidia
# ╰───────────────────────────────────────────────────────────────────

# ╭───────────────────────────────────────────────────────────────────
# │ START: Edits on Config and other optional installations
# ╰───────────────────────────────────────────────────────────────────
print "Setup paths";
print "DOTFILES_FOLDER = $(pwd)";
sed -i "s|DOTFILES_FOLDER = \".*\"|DOTFILES_FOLDER = \"$(pwd)\"|g" "$FILE"

while true; do
    read -p "Enter the name of the browser you want to use/install (e.g., firefox, brave-bin): " browser
    
    # Check if package exists in official Arch repos (pacman)
    if pacman -Si "$browser" &>/dev/null; then
        print "Found '$browser' in official repositories. Installing..."
        sudo pacman -S "$browser" $installer_flags
        
        sed -i "s|Browser = \".*\"|Browser = \"$browser\"|g" "$FILE"
        print "Config updated with Browser = \"$browser\"."
        break
        
    # Check if package exists in AUR (yay)
    elif command -v yay &>/dev/null && yay -Si "$browser" &>/dev/null; then
        print "Found '$browser' in AUR. Installing..."
        yay -S "$browser" $installer_flags
        
        sed -i "s|Browser = \".*\"|Browser = \"$browser\"|g" "$FILE"
        print "Config updated with Browser = \"$browser\"."
        break
    else
        print_error "Package '$browser' could not be found via pacman or yay. Please try again."
    fi
done

yay -S visual-studio-code-bin $installer_flags

while true; do
    read -p "Do you use Spotify? (y/n): " choice
    case "$choice" in 
        [Yy]* ) 
            yay -S spotify $installer_flags
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
                        print "Invalid input. Please answer y or n."
                        ;;
                esac
            done

            break
            ;;
        * ) 
            print "Invalid input. Please answer y or n."
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
            print "Invalid input. Please answer y or n."
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
            print "Invalid input. Please answer y or n."
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
            print "Invalid input. Please answer y or n."
            ;;
    esac
done

# ╭───────────────────────────────────────────────────────────────────
# │ END: Other suggestions
# ╰───────────────────────────────────────────────────────────────────
# ╭───────────────────────────────────────────────────────────────────
# │ START: Setup ln folders
# ╰───────────────────────────────────────────────────────────────────

ln_folders() {
    create_symlink() {
        # Ensure the parent .config directory exists just in case
        mkdir -p "$(dirname "$2")"
        ln -s "$1" "$2"
        print "Symlink created: $2 -> $1"
    }
    if [ -L "$2" ] && [ "$(readlink "$2")" = "$1" ]; then
        print "Symlink already correct: $2 -> $1"
    else
        if [ -d "$2" ]; then
            # Check if the directory is empty using ls -A (returns empty string if no files)
            if [ -z "$(ls -A "$2")" ]; then
                print "Directory is empty. Removing..."
                rm -rf "$2"
                create_symlink "$1" "$2"
            else
                # Directory is not empty, start the prompt loop
                while true; do
                    # Print the warning in red
                    print_error "Folder $2 exists do you want to remove that?\033[0m"
                    read -p "(y/n): " choice1
                    
                    case "$choice1" in 
                        [Yy]* ) 
                            # Second confirmation loop
                            while true; do
                                read -p "Are you sure? (y/n): " choice2
                                case "$choice2" in
                                    [Yy]* )
                                        rm -rf "$2"
                                        create_symlink "$1" "$2"
                                        break 2 # Breaks out of both while loops
                                        ;;
                                    [Nn]* )
                                        print "Skipping symlink."
                                        break 2
                                        ;;
                                    * )
                                        print "Invalid input. Please answer y or n."
                                        ;;
                                esac
                            done
                            ;;
                        [Nn]* ) 
                            print "Skipping symlink."
                            break
                            ;;
                        * ) 
                            print "Invalid input. Please answer y or n."
                            ;;
                    esac
                done
            fi
        else
            # Directory does not exist
            create_symlink "$1" "$2"
        fi
    fi
}

ln_folders "$(pwd)/.config/hypr" "$HOME/.config/hypr"
ln_folders "$(pwd)/.config/kitty" "$HOME/.config/kitty"
ln_folders "$(pwd)/.config/noctalia" "$HOME/.config/noctalia"
ln_folders "$(pwd)/.config/vicinae" "$HOME/.config/vicinae"
ln_folders "$(pwd)/.config/zathura" "$HOME/.config/zathura"

while true; do
    read -p "Copy scripts? (y/n): " choice
    case "$choice" in 
        [Yy]* ) 
            for file in "$(pwd)/scripts"/*; do
    
                # Check if it is an actual file (skips sub-folders if you have any)
                if [ -f "$file" ]; then
                    filename="$(basename "$file")"
                    ln_dotconfig "$file" "$HOME/.local/usr/bin/$filename"                    
                    chmod +x "$file"
                fi
            done
            break
            ;;
        [Nn]* ) 
            print "copy the scripts you want to activate manually into ~/.local/usr/bin and remember to chmod +x all the file to use in a shell globally"
            break
            ;;
        * ) 
            print "Invalid input. Please answer y or n."
            ;;
    esac
done



# ╭───────────────────────────────────────────────────────────────────
# │ END: Setup ln folders
# ╰───────────────────────────────────────────────────────────────────
# ╭───────────────────────────────────────────────────────────────────
# │ START: What to do now?
# ╰───────────────────────────────────────────────────────────────────

print "What to do now?"
print_error "Edit .config/hypr/monitors.lua monitor 'output' and 'mode'\033[0m"
print "kitty +kitten themes"

# ╭───────────────────────────────────────────────────────────────────
# │ END: What to do now?
# ╰───────────────────────────────────────────────────────────────────