---
name: kde-plasma-theme-dev
description: Specialized guidance for creating, renaming, and maintaining KDE Plasma 6 themes. Use when modifying color schemes, plasma themes, or global theme packages.
---

# KDE Plasma 6 Theme Development

This skill provides a structured approach to working with KDE Plasma 6 themes, focusing on renaming, cross-component linking, and solving auto-selection issues.

## Theme Structure Overview

- **Global Theme (Look and Feel):** `global/<id>/` - The "master" package that links everything.
- **Plasma Theme:** `plasma/<id>/` - Panels, widgets, and shell styling.
- **Color Scheme:** `colors/<id>.colors` - System-wide color palette.
- **Wallpaper:** `wallpaper/<id>/` - Packaged wallpaper with `metadata.json`.

## Core Workflows

### 1. Renaming a Theme
Renaming is a multi-step process. Inconsistency leads to "clashes" or broken auto-selection.

1. **Directories:** Rename folders to lowercase-hyphen-case (e.g., `beauty-light`).
2. **Metadata:** Update `Id` in `metadata.json`.
3. **Internal Names:** Keep the user-facing `Name` (e.g., "Beauty Light") but ensure the technical `Id` matches the folder name exactly.
4. **References:** Update `contents/defaults` in the Global Theme to point to the new IDs.

### 2. Solving Auto-Selection Failures
If components don't apply automatically when selecting a Global Theme:

- **Strict ID Matching:** Ensure the `Id` in `metadata.json` matches the folder name.
- **The Hyphen Pitfall:** Color Schemes with hyphens (e.g., `beauty-light`) often fail to auto-apply. Use PascalCase (e.g., `BeautyLight`) for the filename and internal ID to ensure reliability.
- **Defaults Syntax:** Ensure the `defaults` file follows standard KConfig sections.

### 3. Using Standard Components
For maximum stability in Plasma 6, prefer linking to standard system components (like **Breeze** for window decorations) in the `defaults` file rather than bundling custom versions that may have fragile mapping logic.

## References

- [DEFAULTS.md](references/defaults.md) - Correct syntax for `contents/defaults`.
- [NAMING.md](references/naming.md) - ID vs Name vs Folder naming conventions.
- [METADATA.md](references/metadata.md) - Required fields for Plasma 6 compatibility.
