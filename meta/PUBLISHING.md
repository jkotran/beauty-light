# Publishing to the KDE Store

This guide explains how to publish the **Beauty Light** theme so users can find it via the "Get New..." buttons in KDE Plasma System Settings.

## 1. Prerequisites
- **Account:** Create an account at [store.kde.org](https://store.kde.org/) (also known as Pling/OpenDesktop).
- **Screenshots:** Prepare high-quality screenshots. Users rely on visuals to choose themes.

## 2. Packaging Strategy
KDE System Settings looks for specific categories. To make the "Global Theme" work correctly for others, you must upload each sub-component separately and then link them.

### A. Sub-Components (Upload these first)
Create separate product entries for each of these:
1. **Plasma Color Schemes:** Upload `Beauty Color Schemes/beauty-light.colors`.
2. **Plasma Themes:** Zip the contents of `Beauty Plasma Themes/beauty-light/` and upload.
3. **Aurorae Window Decorations:** Zip the contents of `Beauty Window Decorations/beauty-light/` and upload.
4. **Wallpapers:** Zip the `Beauty Wallpapers/beauty-light/` package and upload.

### B. The Global Theme (Upload last)
1. Zip the contents of `Beauty Global Themes/beauty-light/`.
2. Upload to the **Global Themes** category.
3. **Crucial Step:** Once uploaded, go to the product page of each sub-component and copy their **Product ID** (found in the URL or the product backend).
4. Update your `metadata.json` to include these as dependencies if you want them to be downloaded automatically:
   ```json
   "X-KPackage-Dependencies": [
       "kns://colorschemes.knsrc/api.kde-look.org/<ColorID>",
       "kns://plasma-themes.knsrc/api.kde-look.org/<PlasmaID>",
       "kns://aurorae.knsrc/api.kde-look.org/<AuroraeID>"
   ]
   ```

## 3. Uploading via Web Interface
1. Log in to the KDE Store.
2. Click **Add Product** in the top-right.
3. Select the appropriate category (e.g., *Plasma Color Schemes*).
4. Provide the Name, Description, and License (GPLv3).
5. In the **Files** tab, upload your `.colors` file or `.zip` package.

## 4. Verification
Once published:
- Open **System Settings > Colors & Themes > Global Theme**.
- Click **Get New Global Themes...**.
- Search for "Beauty Light".
- Install it and verify that it downloads and applies correctly.

## 5. Maintenance
- When you update the code on GitHub, remember to update the version number in your `metadata.json` and upload the new zip to the KDE Store.
- Users can leave comments and bug reports on the store page; it's good practice to check these occasionally.
