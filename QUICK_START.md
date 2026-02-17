# QUICK START GUIDE
## Get Your App Running in 5 Minutes!

### Step 1: Install Flutter (If Not Already Installed)
⏱️ Time: 10-15 minutes

**Windows/Mac/Linux:**
1. Visit: https://flutter.dev/docs/get-started/install
2. Download Flutter SDK for your OS
3. Extract to a location (e.g., `C:\flutter` or `~/flutter`)
4. Add Flutter to your PATH
5. Run `flutter doctor` to verify installation

**Quick Check:**
```bash
flutter doctor
```
You should see checkmarks ✓ for Flutter and Android toolchain.

---

### Step 2: Install Android Studio
⏱️ Time: 15-20 minutes

1. Download from: https://developer.android.com/studio
2. Install with default settings
3. Open Android Studio
4. Go to: More Actions → SDK Manager
5. Install latest Android SDK
6. Go to: More Actions → Virtual Device Manager
7. Create a new virtual device (Pixel 5 recommended)

---

### Step 3: Set Up Project
⏱️ Time: 2 minutes

1. Extract the `multimedia_app` folder to your desired location
2. Open terminal/command prompt
3. Navigate to the project:
   ```bash
   cd path/to/multimedia_app
   ```
4. Install dependencies:
   ```bash
   flutter pub get
   ```

---

### Step 4: Add Audio Files (CRITICAL!)
⏱️ Time: 5-10 minutes

**Quick Option - Use Text-to-Speech:**

1. Visit: https://ttsmp3.com
2. For **intro.mp3**, paste this text:
   ```
   Welcome to Multimedia Learning. Multimedia refers to the integration of multiple forms of media including text, audio, images, animations, and video into a single interactive experience.
   ```
3. Click "Read" → Download MP3
4. Rename to `intro.mp3`
5. Save to `multimedia_app/assets/audio/intro.mp3`

6. For **text.mp3**, paste:
   ```
   Text is the most fundamental element of multimedia. It conveys information, provides context, and guides user interaction.
   ```
7. Download, rename to `text.mp3`, save to audio folder

8. For **animation.mp3**, paste:
   ```
   Animation brings static elements to life through motion and enhances user engagement.
   ```
9. Download, rename to `animation.mp3`, save to audio folder

**Alternative - Record Your Own:**
- Use your phone's voice recorder
- Record the scripts above
- Transfer to computer
- Save as MP3 in `assets/audio/` folder

---

### Step 5: Run the App
⏱️ Time: 2 minutes

1. Start your Android emulator (or connect physical device)
2. In the terminal, run:
   ```bash
   flutter run
   ```
3. Wait for app to build and install
4. App should open automatically!

---

## 🎉 SUCCESS! Your App is Running

### Test Everything:
1. ✅ Home screen shows with animation
2. ✅ Tap "Introduction to Multimedia"
3. ✅ Press play button - audio should play
4. ✅ Navigate to "Elements of Multimedia"
5. ✅ Explore all 5 tabs
6. ✅ Go to "Interactive Demo"
7. ✅ See animations and tap interactive elements

---

## Common Issues & Quick Fixes

### "Audio file not found"
**Fix:**
- Check files are in `assets/audio/` folder
- File names must be exactly: `intro.mp3`, `text.mp3`, `animation.mp3`
- Run `flutter pub get` again
- Restart the app

### "No connected devices"
**Fix:**
- Start your Android emulator:
  ```bash
  flutter emulators --launch <emulator_name>
  ```
- Or check if physical device has USB debugging enabled

### "Gradle build failed"
**Fix:**
```bash
flutter clean
flutter pub get
flutter run
```

### "SDK not found"
**Fix:**
- Open Android Studio
- Tools → SDK Manager
- Install latest Android SDK
- Accept licenses:
  ```bash
  flutter doctor --android-licenses
  ```

---

## Building APK for Presentation

After everything works:

```bash
# Build release APK
flutter build apk --release

# Find APK at:
# build/app/outputs/flutter-apk/app-release.apk
```

Transfer this APK to your phone or use in presentation!

---

## Next Steps

1. ✅ Test all features thoroughly
2. ✅ Take screenshots for your report
3. ✅ Record screen demo for presentation
4. ✅ Build final APK
5. ✅ Prepare presentation points (see README.md)

---

## Need Help?

1. Check the main `README.md` for detailed documentation
2. Review error messages carefully
3. Run `flutter doctor -v` for diagnostics
4. Check `assets/audio/INSTRUCTIONS.md` for audio help

---

## Time Breakdown

- Flutter setup: 25 minutes
- Project setup: 2 minutes
- Audio files: 10 minutes
- First run: 2 minutes
- **Total: ~40 minutes to working app!**

---

**You're all set! Good luck with your project! 🚀**
