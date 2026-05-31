# Naming Conventions for Plasma 6

| Field | Example Value | Purpose |
| :--- | :--- | :--- |
| **Folder Name** | `beauty-light` | The primary ID. Used in paths. |
| **Internal Id** | `beauty-light` | Must match Folder Name exactly. |
| **PluginId** | `beauty-light` | Used in `metadata.desktop`. |
| **Display Name** | `Beauty Light` | What the user sees in settings. |

## The "PascalCase" Recommendation (Most Robust Path)
While all-lowercase with hyphens is common, Plasma 6 relies on a mix of new JSON standards and older legacy engines (like Aurorae). The "least common denominator" that every KDE sub-engine reliably understands is a single PascalCase string (e.g., `BeautyLight`) with no hyphens or spaces. If you experience persistent auto-selection failures with hyphenated IDs, pivoting all IDs and folder names to PascalCase is the most robust path to resolution.

## Hyphenated Names
KDE Store often uses hyphens (e.g., `Beauty-Color-Light`). For local standalone derivatives, simple IDs without too many hyphens often resolve mapping bugs.
