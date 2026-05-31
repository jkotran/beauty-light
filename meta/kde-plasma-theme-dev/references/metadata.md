# Plasma 6 Metadata Requirements

## metadata.json (Preferred)
Required for Global and Plasma themes.
- `KPackageStructure`: `Plasma/LookAndFeel` or `Plasma/Theme`.
- `KPlugin`: Contains `Id`, `Name`, `Category`, and `ServiceTypes`.

## metadata.desktop (Legacy)
Still required for many icon packs and legacy plugins.
- `X-KDE-PluginInfo-Name`: Must match the `Id`.
- `X-KDE-PluginInfo-Category`: Used to categorize the theme component.
