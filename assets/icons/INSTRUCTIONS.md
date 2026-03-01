# 📱 Custom App Icon & Splash Screen Guide

A step-by-step guide for adding a custom app icon and splash screen to a Flutter project.

---

## 📋 Prerequisites

- Flutter installed and working
- Your project open in VS Code or Android Studio
- A square image for your icon (PNG or JPEG, at least **1024x1024px**)

---

## 🖼️ Step 1 — Prepare Your Icon Image

Your icon image must be:
- **Square** (same width and height)
- At least **1024x1024px**
- **PNG format** preferred (JPEG works too)

> 💡 **Don't have a PNG?** If you only have a JPEG, you can convert it using a free tool like [CloudConvert](https://cloudconvert.com) or [Squoosh](https://squoosh.app). Just upload your JPEG and export as PNG.

---

## 🗂️ Step 2 — Generate Your Launcher Icons (5 Sizes)

Android requires **5 different sizes** of your icon — one for each screen density folder. You need to generate all 5 before placing them.

### Option A — Use a Free Online Generator (Recommended)

1. Go to [icon.kitchen](https://icon.kitchen) or [appicon.ai](https://appicon.ai)
2. Upload your image
3. Download the generated zip file
4. Unzip it — you will find folders named exactly like the ones in your project

### Option B — Use Claude 🤖

Upload your image to Claude and ask:
> "Generate all 5 Android launcher icon sizes for my Flutter app"

Claude will produce all 5 files at the correct sizes ready to download.

### The 5 Required Sizes

| Folder | Size Needed |
|--------|-------------|
| `mipmap-mdpi` | 48 × 48 px |
| `mipmap-hdpi` | 72 × 72 px |
| `mipmap-xhdpi` | 96 × 96 px |
| `mipmap-xxhdpi` | 144 × 144 px |
| `mipmap-xxxhdpi` | 192 × 192 px |

> ⚠️ Each folder needs a **different sized** version of your icon. Do NOT put the same file in all folders — it will look blurry on high resolution screens.

---

## 📂 Step 3 — Place the Icons in Your Project

This is where most people get confused. Follow carefully.

### Where to go in your project

Navigate to this path inside your Flutter project:

```
your_project/
  android/
    app/
      src/
        main/
          res/              ← THIS is where all 5 mipmap folders are
            mipmap-mdpi/
            mipmap-hdpi/
            mipmap-xhdpi/
            mipmap-xxhdpi/
            mipmap-xxxhdpi/
```

### What to do in each folder

Inside **each** mipmap folder you will find an existing file called `ic_launcher.png`. This is the default Flutter icon. You need to **replace it** with your own.

Do this **5 times** — once per folder:

**For `mipmap-mdpi`:**
1. Take the **48×48px** version of your icon
2. Rename it to `ic_launcher.png`
3. Open `android/app/src/main/res/mipmap-mdpi/` in your file manager
4. Delete the old `ic_launcher.png` that is there
5. Paste your new `ic_launcher.png` into the folder

**For `mipmap-hdpi`:**
1. Take the **72×72px** version of your icon
2. Rename it to `ic_launcher.png`
3. Open `android/app/src/main/res/mipmap-hdpi/`
4. Delete the old `ic_launcher.png`
5. Paste your new one in

**Repeat the same steps for:**
- `mipmap-xhdpi` → use the **96×96px** version
- `mipmap-xxhdpi` → use the **144×144px** version
- `mipmap-xxxhdpi` → use the **192×192px** version

### Doing it via Terminal (Ubuntu/Linux/Mac)

If you prefer the terminal, run these commands. Replace `~/Desktop/your_project` with your actual project path and `/path/to/your/icons` with where your generated icons are saved:

```bash
cp /path/to/your/icons/mipmap-mdpi/ic_launcher.png \
   ~/Desktop/your_project/android/app/src/main/res/mipmap-mdpi/ic_launcher.png

cp /path/to/your/icons/mipmap-hdpi/ic_launcher.png \
   ~/Desktop/your_project/android/app/src/main/res/mipmap-hdpi/ic_launcher.png

cp /path/to/your/icons/mipmap-xhdpi/ic_launcher.png \
   ~/Desktop/your_project/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png

cp /path/to/your/icons/mipmap-xxhdpi/ic_launcher.png \
   ~/Desktop/your_project/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png

cp /path/to/your/icons/mipmap-xxxhdpi/ic_launcher.png \
   ~/Desktop/your_project/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
```

> 💡 The `cp` command will automatically replace the old file. No need to delete first.

---

## 📁 Step 4 — Add Master Icon to Assets

1. Inside your Flutter project, open the `assets` folder
2. Create a new folder called `icons` inside it
3. Place your full size (1024×1024px) icon there named `app_icon.png`:

```
your_project/
  assets/
    icons/
      app_icon.png    ← place your full size icon here
```

4. Open `pubspec.yaml` and make sure `assets/icons/` is declared:

```yaml
flutter:
  assets:
    - assets/icons/
    - assets/images/   # keep any other folders you already have
    - assets/audio/
    - assets/videos/
```

---

## 📦 Step 5 — Add Required Packages

Open `pubspec.yaml` and add under `dev_dependencies`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1
  flutter_native_splash: ^2.3.9
```

---

## ⚙️ Step 6 — Configure the Icon & Splash Screen

At the **very bottom** of `pubspec.yaml` (outside of any other section), add:

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
  min_sdk_android: 21
  adaptive_icon_background: "#D32F2F"     # change to your preferred color
  adaptive_icon_foreground: "assets/icons/app_icon.png"

flutter_native_splash:
  color: "#D32F2F"                        # splash background color (light mode)
  image: assets/icons/app_icon.png
  color_dark: "#B71C1C"                   # splash background color (dark mode)
  image_dark: assets/icons/app_icon.png
  android_12:
    icon_background_color: "#D32F2F"
    image: assets/icons/app_icon.png
```

> 💡 Change `#D32F2F` to any hex color. Use [htmlcolorcodes.com](https://htmlcolorcodes.com) to pick one.

> ⚠️ This config must be at the **root level** of `pubspec.yaml` — NOT indented inside `flutter:`.

---

## 🔧 Step 7 — Run the Generators

Open your terminal inside the project folder and run these commands **one by one**:

```bash
# 1. Get the packages
flutter pub get

# 2. Generate icons (overwrites the mipmap files automatically)
dart run flutter_launcher_icons

# 3. Generate the splash screen
dart run flutter_native_splash:create

# 4. Clean and rebuild
flutter clean && flutter run
```

> 💡 If you already manually replaced the mipmap files in Step 3, you can skip `dart run flutter_launcher_icons` — your icons are already placed.

---

## ✅ Final pubspec.yaml Structure Overview

```yaml
name: your_app
version: 1.0.0

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  # ... your other dependencies

dev_dependencies:
  flutter_launcher_icons: ^0.13.1    # ← added here
  flutter_native_splash: ^2.3.9      # ← added here

flutter:
  assets:
    - assets/icons/                   # ← make sure this is here
    - assets/images/
    - assets/audio/
    - assets/videos/

# ↓ These go at the very bottom, outside of flutter:
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
  min_sdk_android: 21
  adaptive_icon_background: "#D32F2F"
  adaptive_icon_foreground: "assets/icons/app_icon.png"

flutter_native_splash:
  color: "#D32F2F"
  image: assets/icons/app_icon.png
  color_dark: "#B71C1C"
  image_dark: assets/icons/app_icon.png
  android_12:
    icon_background_color: "#D32F2F"
    image: assets/icons/app_icon.png
```

---

## 🛠️ Troubleshooting

**Icon not updating after replacing files?**
```bash
flutter clean && flutter pub get && flutter run
```

**Still showing old icon?**
- Uninstall the app from your device/emulator completely, then run again

**`dart run flutter_launcher_icons` fails?**
- Make sure `flutter_launcher_icons` is under `dev_dependencies` not `dependencies`
- Make sure the image path matches exactly where you placed the file

**Splash screen not showing?**
- Make sure you ran `dart run flutter_native_splash:create` before `flutter run`

**Image path error?**
- Double check `assets/icons/` is declared under `flutter: assets:` in pubspec.yaml
- File names are case-sensitive — `app_icon.png` ≠ `App_Icon.PNG`

---

## 📚 Useful Resources

- [flutter_launcher_icons package](https://pub.dev/packages/flutter_launcher_icons)
- [flutter_native_splash package](https://pub.dev/packages/flutter_native_splash)
- [Icon Kitchen — free icon generator](https://icon.kitchen)
- [HTML Color Codes picker](https://htmlcolorcodes.com)
- [CloudConvert — JPEG to PNG](https://cloudconvert.com)