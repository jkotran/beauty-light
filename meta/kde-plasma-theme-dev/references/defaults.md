# Plasma 6 Defaults Configuration

The `contents/defaults` file in a Global Theme tells Plasma which sub-components to apply.

## Color Scheme
```ini
[kdeglobals][General]
ColorScheme=BeautyLight
```
*Note: Use PascalCase (no hyphens) for the ID and filename to ensure the Global Theme mapping engine finds it reliably.*

## Window Decoration (Standard)
To ensure stability and native performance (hardware acceleration), point to the system-standard Breeze decoration. This is the most reliable way to ensure window borders apply automatically in Plasma 6.
```ini
[kwinrc][org.kde.kdecoration2]
library=org.kde.breeze
theme=Breeze
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
