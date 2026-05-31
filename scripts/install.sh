#!/usr/bin/env bash

# Configuration
THEME_NAME="beauty-light"
DISPLAY_NAME="Beauty Light"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Source paths
GLOBAL_THEME_SRC="$REPO_ROOT/global/$THEME_NAME"
PLASMA_THEME_SRC="$REPO_ROOT/plasma/$THEME_NAME"
AURORAE_THEME_SRC="$REPO_ROOT/aurorae/$THEME_NAME"
COLOR_SCHEME_SRC="$REPO_ROOT/colors/beauty-light.colors"
WALLPAPER_SRC="$REPO_ROOT/wallpaper/beauty-light.png"

# Defaults
ACTION="install"
DRY_RUN=false
HOME_DIR="$HOME"

# Help
show_help() {
    echo "Usage: $0 [--install|--uninstall] [--home PATH] [--dry-run]"
    echo "  --install      Install Beauty Light locally (default)"
    echo "  --uninstall    Uninstall Beauty Light locally"
    echo "  --home PATH    Override local home directory"
    echo "  --dry-run      Print planned actions without changing files"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --install)
            ACTION="install"
            shift
            ;;
        --uninstall)
            ACTION="uninstall"
            shift
            ;;
        --home)
            HOME_DIR="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Expand HOME_DIR if it starts with ~
if [[ "$HOME_DIR" == "~"* ]]; then
    HOME_DIR="${HOME_DIR/#\~/$HOME}"
fi

SHARE_DIR="$HOME_DIR/.local/share"
GLOBAL_THEME_DEST="$SHARE_DIR/plasma/look-and-feel/$THEME_NAME"
PLASMA_THEME_DEST="$SHARE_DIR/plasma/desktoptheme/$THEME_NAME"
AURORAE_THEME_DEST="$SHARE_DIR/aurorae/themes/$THEME_NAME"
COLOR_SCHEME_DEST="$SHARE_DIR/color-schemes/beauty-light.colors"
WALLPAPER_DEST_DIR="$SHARE_DIR/wallpapers/$THEME_NAME"

log_action() {
    if [ "$DRY_RUN" = true ]; then
        echo "+ [DRY RUN] $1"
    else
        echo "+ $1"
    fi
}

install_theme() {
    echo "Installing $DISPLAY_NAME locally to $HOME_DIR"

    # Check sources
    for src in "$GLOBAL_THEME_SRC" "$PLASMA_THEME_SRC" "$AURORAE_THEME_SRC" "$COLOR_SCHEME_SRC" "$WALLPAPER_SRC"; do
        if [ ! -e "$src" ]; then
            echo "Error: Missing source path: $src"
            exit 1
        fi
    done

    # Create directories
    for dir in "$SHARE_DIR/plasma/look-and-feel" "$SHARE_DIR/plasma/desktoptheme" "$SHARE_DIR/aurorae/themes" "$SHARE_DIR/color-schemes" "$SHARE_DIR/wallpapers"; do
        if [ "$DRY_RUN" = false ]; then
            mkdir -p "$dir"
        else
            log_action "mkdir -p $dir"
        fi
    done

    # Copy files
    log_action "Copying Global Theme..."
    if [ "$DRY_RUN" = false ]; then
        rm -rf "$GLOBAL_THEME_DEST"
        cp -r "$GLOBAL_THEME_SRC" "$GLOBAL_THEME_DEST"
    else
        log_action "rm -rf $GLOBAL_THEME_DEST && cp -r $GLOBAL_THEME_SRC $GLOBAL_THEME_DEST"
    fi

    log_action "Copying Plasma Theme..."
    if [ "$DRY_RUN" = false ]; then
        rm -rf "$PLASMA_THEME_DEST"
        cp -r "$PLASMA_THEME_SRC" "$PLASMA_THEME_DEST"
    else
        log_action "rm -rf $PLASMA_THEME_DEST && cp -r $PLASMA_THEME_SRC $PLASMA_THEME_DEST"
    fi

    log_action "Copying Aurorae Theme..."
    if [ "$DRY_RUN" = false ]; then
        rm -rf "$AURORAE_THEME_DEST"
        cp -r "$AURORAE_THEME_SRC" "$AURORAE_THEME_DEST"
    else
        log_action "rm -rf $AURORAE_THEME_DEST && cp -r $AURORAE_THEME_SRC $AURORAE_THEME_DEST"
    fi

    log_action "Copying Color Scheme..."
    if [ "$DRY_RUN" = false ]; then
        cp "$COLOR_SCHEME_SRC" "$COLOR_SCHEME_DEST"
    else
        log_action "cp $COLOR_SCHEME_SRC $COLOR_SCHEME_DEST"
    fi

    # Wallpaper package
    log_action "Creating Wallpaper package..."
    WALLPAPER_IMAGES_DIR="$WALLPAPER_DEST_DIR/contents/images"
    if [ "$DRY_RUN" = false ]; then
        mkdir -p "$WALLPAPER_IMAGES_DIR"
        cp "$WALLPAPER_SRC" "$WALLPAPER_IMAGES_DIR/1920x1080.png"
        
        # Metadata.json
        cat > "$WALLPAPER_DEST_DIR/metadata.json" <<EOF
{
    "KPlugin": {
        "Id": "$THEME_NAME",
        "License": "CC-BY-SA-4.0",
        "Name": "$THEME_NAME"
    },
    "X-KDE-PlasmaImageWallpaper-AccentColor": {
        "Light": "#5e81ac",
        "Dark": "#5e81ac"
    }
}
EOF
    else
        log_action "mkdir -p $WALLPAPER_IMAGES_DIR"
        log_action "cp $WALLPAPER_SRC $WALLPAPER_IMAGES_DIR/1920x1080.png"
        log_action "Write $WALLPAPER_DEST_DIR/metadata.json"
    fi

    echo "$DISPLAY_NAME installation complete."
}

uninstall_theme() {
    echo "Uninstalling $DISPLAY_NAME from $HOME_DIR"

    REMOVALS=(
        "$GLOBAL_THEME_DEST"
        "$PLASMA_THEME_DEST"
        "$AURORAE_THEME_DEST"
        "$COLOR_SCHEME_DEST"
        "$WALLPAPER_DEST_DIR"
    )

    for path in "${REMOVALS[@]}"; do
        log_action "Removing $path"
        if [ "$DRY_RUN" = false ]; then
            rm -rf "$path"
        fi
    done

    echo "$DISPLAY_NAME uninstallation complete."
}

if [ "$ACTION" = "install" ]; then
    install_theme
else
    uninstall_theme
fi
