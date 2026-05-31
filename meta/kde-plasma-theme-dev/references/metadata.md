# Plasma 6 Metadata Requirements

## metadata.json (Preferred)
Required for Global and Plasma themes.
- `KPackageStructure`: `Plasma/LookAndFeel` or `Plasma/Theme`.
- `KPlugin`: Contains `Id`, `Name`, `Category`, and `ServiceTypes`.

## metadata.desktop (Legacy/Aurorae)
Still required for many Aurorae themes and icon packs.
- `X-KDE-PluginInfo-Name`: Must match the `Id`.
- `X-KDE-PluginInfo-Category`: Must be `KWin/Decoration` for Aurorae themes.

## AURORAERC
The `beauty-lightrc` (or similar) file inside the Aurorae theme folder:
- Controls padding, borders, and text colors.
- Title: `[General]`
- Keys: `ActiveTextColor`, `InactiveTextColor`, etc.
