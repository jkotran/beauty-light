# Plasma 6 Defaults Configuration

The `contents/defaults` file in a Global Theme tells Plasma which sub-components to apply.

## Color Scheme
```ini
[kdeglobals][General]
ColorScheme=beauty-light
```
*Note: This must match the filename of the `.colors` file (minus the extension) AND the internal `ColorScheme` key.*

## Window Decoration (Aurorae)
Plasma 6 is sensitive to the group name. Include these variations:
```ini
[kwinrc][org.kde.kdecoration2]
library=org.kde.kwin.aurorae
theme=__aurorae__svg__beauty-light
ButtonsOnLeft=XIA
ButtonsOnRight=
```

## Wallpaper
Requires the `org.kde.plasma.desktop` section for reliability in Plasma 6:
```ini
[org.kde.plasma.desktop]
Wallpaper=org.kde.image
WallpaperPackage=beauty-light
```

## Icons
```ini
[kdeglobals][Icons]
Theme=Slot-Dark-Icons
```
*Pitfall: If the icon theme isn't installed, Plasma falls back to Breeze.*
