# Naming Conventions for Plasma 6

| Field | Example Value | Purpose |
| :--- | :--- | :--- |
| **Folder Name** | `beauty-light` | The primary ID. Used in paths. |
| **Internal Id** | `beauty-light` | Must match Folder Name exactly. |
| **Display Name** | `Beauty Light` | What the user sees in settings. |

## The "PascalCase" Recommendation (Most Robust Path)
Plasma 6 relies on a mix of new JSON standards and older legacy engines. The "least common denominator" that every KDE sub-engine reliably understands is a single PascalCase string (e.g., `BeautyLight`) with no hyphens or spaces. 

**Proven Success:** Using PascalCase for the Color Scheme ID (`BeautyLight`) solved auto-selection failures where hyphenated names (`beauty-light`) failed, even when manual application worked. 

If you experience persistent auto-selection failures with hyphenated IDs, pivoting IDs and folder names to PascalCase is the most robust path to resolution.
