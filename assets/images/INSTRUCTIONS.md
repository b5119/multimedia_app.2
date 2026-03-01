# Image Files Instructions

## Suggested Image Files (Optional)

You can add PNG or JPG images to enhance the visual appeal:

1. **multimedia.png** - General multimedia concept graphic
2. **audio.png** - Audio/speaker icon or graphic
3. **video.png** - Video/camera icon or graphic

## Where to Get Images

### Option 1: Free Stock Photos
- **Unsplash**: https://unsplash.com
- **Pexels**: https://pexels.com
- **Pixabay**: https://pixabay.com

Search terms:
- "multimedia"
- "technology education"
- "audio speaker"
- "video camera"
- "digital learning"

### Option 2: Icon Libraries
- **Flaticon**: https://flaticon.com
- **Icons8**: https://icons8.com
- Download PNG format, 512x512 or larger

### Option 3: Create Your Own
- Use Canva (free): https://canva.com
- Create simple graphics with text and shapes
- Export as PNG

### Option 4: Screenshot From App
- The app already has built-in icons
- Images are optional for enhanced visuals
- App will work perfectly without custom images

## Image Specifications

- **Format**: PNG (recommended) or JPG
- **Size**: 512x512 to 1024x1024 pixels
- **File Size**: Keep under 500KB each
- **Orientation**: Square or landscape preferred

## How to Add Images

1. Download or create your images
2. Rename them appropriately
3. Save to this folder (`assets/images/`)
4. Run `flutter pub get`
5. Restart the app

## Image Usage in App

Currently, the app uses Material Design icons which look professional.
Custom images would be used if you reference them in the code:

```dart
Image.asset('assets/images/multimedia.jpg')
```

## Not Required

**Important:** Images are OPTIONAL. The app uses beautiful vector icons by default and will work perfectly without custom images. Only add images if you want to customize the visual appearance.
