import 'package:flutter/material.dart';
import '../widgets/audio_player_widget.dart';
import '../widgets/animated_card.dart';
import '../widgets/video_player_widget.dart';
import '../widgets/interactive_graphics_demo.dart';

// Helper widget for hints
class HelpHint extends StatelessWidget {
  final String message;
  final IconData icon;

  const HelpHint({
    super.key,
    required this.message,
    this.icon = Icons.touch_app,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ElementsScreen extends StatefulWidget {
  const ElementsScreen({super.key});

  @override
  State<ElementsScreen> createState() => _ElementsScreenState();
}

class _ElementsScreenState extends State<ElementsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elements of Multimedia'),
        backgroundColor: const Color(0xFFD32F2F),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.text_fields), text: 'Text'),
            Tab(icon: Icon(Icons.audiotrack), text: 'Audio'),
            Tab(icon: Icon(Icons.videocam), text: 'Video'),
            Tab(icon: Icon(Icons.animation), text: 'Animation'),
            Tab(icon: Icon(Icons.image), text: 'Graphics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTextTab(),
          _buildAudioTab(),
          _buildVideoTab(),
          _buildAnimationTab(),
          _buildGraphicsTab(),
        ],
      ),
    );
  }

  Widget _buildTextTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AnimatedCard(
            icon: Icons.text_fields,
            title: 'Text in Multimedia',
            color: Color(0xFF1976D2),
          ),

          const SizedBox(height: 20),

          const HelpHint(
            message: '📖 Scroll down to explore different text styles and formatting',
            icon: Icons.arrow_downward,
          ),

          _buildSectionTitle('Overview'),
          _buildContentText(
              'Text is the most fundamental element of multimedia. It conveys information, '
                  'provides context, and guides user interaction. Text can be static or dynamic, '
                  'formatted in various fonts, sizes, colors, and styles.'
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Types of Text'),
          _buildBulletPoint('Plain Text - Basic unformatted text'),
          _buildBulletPoint('Formatted Text - Styled with fonts, colors, sizes'),
          _buildBulletPoint('Hypertext - Interactive text with links'),
          _buildBulletPoint('Animated Text - Text with motion effects'),

          const SizedBox(height: 20),

          _buildSectionTitle('Text Examples'),
          _buildExampleBox(
            'Different Text Styles',
            [
              'Normal text for body content',
              'Bold text for emphasis',
              'Italic text for notes',
              'UPPERCASE FOR HEADINGS',
              'Colored text for highlights',
            ],
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Applications'),
          _buildContentText(
              'Text is used in menus, captions, subtitles, instructions, hyperlinks, and informational displays. '
                  'Good typography improves readability and user experience.'
          ),

          const SizedBox(height: 20),

          _buildInfoCard(
            icon: Icons.lightbulb_outline,
            title: 'Typography Tip',
            content: 'Use proper font hierarchy: large headings, medium subheadings, and comfortable body text sizes.',
            color: Colors.blue.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildAudioTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AnimatedCard(
            icon: Icons.audiotrack,
            title: 'Audio in Multimedia',
            color: Color(0xFF7B1FA2),
          ),

          const SizedBox(height: 20),

          const HelpHint(
            message: '🎧 Press the play button below to hear audio narration',
            icon: Icons.headphones,
          ),

          AudioPlayerWidget(
            audioPath: 'assets/audio/text.mp3',
            title: 'Sample Audio Narration',
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('What is Audio?'),
          _buildContentText(
              'Audio refers to sound content in digital form. It includes music, speech, sound effects, '
                  'and ambient noise. Audio enhances user experience by providing another sensory dimension.'
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Audio Types'),
          _buildBulletPoint('Speech/Narration - Human voice recordings'),
          _buildBulletPoint('Music - Background scores and soundtracks'),
          _buildBulletPoint('Sound Effects - Environmental and action sounds'),
          _buildBulletPoint('Synthesized Audio - Computer-generated sounds'),

          const SizedBox(height: 20),

          _buildSectionTitle('Common Audio Formats'),
          Row(
            children: [
              _buildFormatChip('MP3'),
              _buildFormatChip('WAV'),
              _buildFormatChip('AAC'),
              _buildFormatChip('OGG'),
              _buildFormatChip('FLAC'),
            ],
          ),

          const SizedBox(height: 20),

          _buildInfoCard(
            icon: Icons.info_outline,
            title: 'Audio Quality',
            content: 'MP3 offers good quality with small file sizes, while WAV provides uncompressed audio for professional use.',
            color: Colors.purple.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildVideoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AnimatedCard(
            icon: Icons.videocam,
            title: 'Video in Multimedia',
            color: Color(0xFFD32F2F),
          ),

          const SizedBox(height: 20),

          const HelpHint(
            message: '📹 Press play to watch the video demonstration',
            icon: Icons.play_circle,
          ),

          // Video Player
          VideoPlayerWidget(
            videoPath: 'assets/videos/sample.mp4',
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('About Video'),
          _buildContentText(
              'Video is a sequence of images (frames) displayed rapidly to create the illusion of motion. '
                  'It combines visual and audio elements to deliver rich multimedia content.'
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Video Characteristics'),
          _buildBulletPoint('Frame Rate - Typically 24, 30, or 60 fps'),
          _buildBulletPoint('Resolution - Quality measured in pixels (HD, 4K)'),
          _buildBulletPoint('Codec - Compression algorithm (H.264, VP9)'),
          _buildBulletPoint('Bitrate - Data transmission rate'),

          const SizedBox(height: 20),

          _buildSectionTitle('Common Video Formats'),
          Row(
            children: [
              _buildFormatChip('MP4'),
              _buildFormatChip('AVI'),
              _buildFormatChip('MOV'),
              _buildFormatChip('MKV'),
              _buildFormatChip('WebM'),
            ],
          ),

          const SizedBox(height: 20),

          _buildInfoCard(
            icon: Icons.video_library,
            title: 'Video Usage',
            content: 'MP4 is the most widely supported format, ideal for web and mobile applications.',
            color: Colors.red.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AnimatedCard(
            icon: Icons.animation,
            title: 'Animation in Multimedia',
            color: Color(0xFFF57C00),
          ),

          const SizedBox(height: 20),

          const HelpHint(
            message: '✨ Watch the shapes below animate automatically',
            icon: Icons.animation,
          ),

          // Animation Demo
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Transform.rotate(
                    angle: value * 2 * 3.14159,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.star, size: 50, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('What is Animation?'),
          _buildContentText(
              'Animation is the illusion of motion created by displaying a sequence of images or frames. '
                  'It brings static elements to life and enhances user engagement through dynamic visual content.'
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Types of Animation'),
          _buildBulletPoint('2D Animation - Flat, traditional animation'),
          _buildBulletPoint('3D Animation - Three-dimensional computer graphics'),
          _buildBulletPoint('Motion Graphics - Animated graphic design'),
          _buildBulletPoint('Stop Motion - Frame-by-frame photography'),
          _buildBulletPoint('UI Animation - Interactive interface transitions'),

          const SizedBox(height: 20),

          _buildSectionTitle('Animation Principles'),
          _buildBulletPoint('Timing and Spacing - Controls speed and rhythm'),
          _buildBulletPoint('Ease In/Ease Out - Natural acceleration'),
          _buildBulletPoint('Anticipation - Prepares viewer for action'),
          _buildBulletPoint('Follow-through - Continues motion naturally'),

          const SizedBox(height: 20),

          _buildInfoCard(
            icon: Icons.speed,
            title: 'Performance Tip',
            content: 'Smooth animations run at 60 frames per second (60fps) for the best user experience.',
            color: Colors.orange.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildGraphicsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AnimatedCard(
            icon: Icons.image,
            title: 'Graphics in Multimedia',
            color: Color(0xFF00897B),
          ),

          const SizedBox(height: 20),

          const HelpHint(
            message: '🎨 Tap anywhere on the interactive area below to create colorful graphics!',
            icon: Icons.touch_app,
          ),

          // Interactive Graphics Demo
          const InteractiveGraphicsDemo(),

          const SizedBox(height: 20),

          // Graphics Types Demo
          _buildSectionTitle('Graphics Types'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGraphicExample(Icons.photo, 'Raster', Colors.blue),
              _buildGraphicExample(Icons.change_history, 'Vector', Colors.green),
              _buildGraphicExample(Icons.palette, 'Illustration', Colors.purple),
            ],
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('About Graphics'),
          _buildContentText(
              'Graphics are visual elements including images, illustrations, icons, and diagrams. '
                  'They communicate information visually and enhance aesthetic appeal.'
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Graphics Categories'),
          _buildBulletPoint('Raster Graphics - Pixel-based images (JPEG, PNG)'),
          _buildBulletPoint('Vector Graphics - Path-based scalable graphics (SVG)'),
          _buildBulletPoint('3D Graphics - Three-dimensional models and renders'),
          _buildBulletPoint('Infographics - Visual data representation'),

          const SizedBox(height: 20),

          _buildSectionTitle('Common Image Formats'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFormatChip('JPEG'),
              _buildFormatChip('PNG'),
              _buildFormatChip('GIF'),
              _buildFormatChip('SVG'),
              _buildFormatChip('WebP'),
            ],
          ),

          const SizedBox(height: 20),

          _buildInfoCard(
            icon: Icons.image_aspect_ratio,
            title: 'Format Guide',
            content: 'Use JPEG for photos, PNG for transparency, SVG for scalable icons, and GIF for simple animations.',
            color: Colors.teal.shade700,
          ),
        ],
      ),
    );
  }

  Widget _buildGraphicExample(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, size: 40, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFD32F2F),
        ),
      ),
    );
  }

  Widget _buildContentText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        height: 1.6,
        color: Colors.black87,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFD32F2F),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormatChip(String format) {
    return Chip(
      label: Text(format),
      backgroundColor: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildExampleBox(String title, List<String> examples) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 10),
          ...examples.map((example) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              example,
              style: const TextStyle(fontSize: 15),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}