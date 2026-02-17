# Audio Files Instructions

## Required Audio Files

You need to add 3 MP3 files to this folder:

1. **intro.mp3** - Introduction to Multimedia narration (30-40 seconds)
2. **text.mp3** - Text element explanation (20-30 seconds)
3. **animation.mp3** - Animation demonstration narration (20-30 seconds)

## How to Create Audio Files

### Option 1: Record on Your Phone
1. Open your phone's voice recorder app
2. Record your narration clearly
3. Save as MP3 or M4A format
4. If M4A, convert to MP3 using online converter (e.g., https://convertio.co)
5. Transfer files to this folder

### Option 2: Record on Computer
1. Use Audacity (free software)
2. Record your narration
3. Export as MP3
4. Save files to this folder

### Option 3: Use Text-to-Speech (Quick Solution)
1. Visit: https://ttsmp3.com
2. Enter your script text
3. Choose voice (English)
4. Download as MP3
5. Save files to this folder

## Sample Narration Scripts

### intro.mp3
"Welcome to Multimedia Learning. Multimedia refers to the integration of multiple forms of media including text, audio, images, animations, and video into a single interactive experience. It combines various content forms to present information in a rich and engaging way."

### text.mp3
"Text is the most fundamental element of multimedia. It conveys information, provides context, and guides user interaction. Text can be static or dynamic, formatted in various fonts, sizes, colors, and styles to enhance readability and user experience."

### animation.mp3
"Animation brings static elements to life through motion. It enhances user engagement by creating dynamic visual content that captures attention and illustrates concepts in ways that static images cannot."

## After Adding Files

1. Ensure files are named exactly as shown (lowercase, no spaces)
2. Run `flutter pub get` in the terminal
3. Restart the app
4. Audio should play when you press the play button

## File Size Recommendations

- Keep each file under 1MB
- Use 128kbps bitrate for good quality
- Mono audio is sufficient for narration
- Sample rate: 44.1kHz or 48kHz

## Troubleshooting

**Audio not playing?**
- Check file names match exactly (case-sensitive)
- Ensure files are MP3 format
- Verify files are in the correct folder
- Restart the Flutter app

**File too large?**
- Reduce bitrate to 96kbps or 64kbps
- Use mono instead of stereo
- Trim silence at start/end
- Use online MP3 compressor
