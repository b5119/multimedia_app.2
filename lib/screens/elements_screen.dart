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
            message: '📖 Scroll down to explore different text styles',
            icon: Icons.arrow_downward,
          ),

          _buildSectionTitle('Overview'),
          _buildContentText(
              'Text is the most fundamental element of multimedia. It conveys information, '
                  'provides context, and guides user interaction.'
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Types of Text'),
          _buildBulletPoint('Plain Text - Basic unformatted text'),
          _buildBulletPoint('Formatted Text - Styled with fonts, colors, sizes'),
          _buildBulletPoint('Hypertext - Interactive text with links'),
          _buildBulletPoint('Animated Text - Text with motion effects'),

          const SizedBox(height: 20),

          _buildExampleBox(
            'Example Text Styles',
            [
              'Normal text',
              'Bold text',
              'Italic text',
              'UPPERCASE TEXT',
              'Colored Text',
            ],
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
            message: '🎧 Press play to hear audio narration',
            icon: Icons.headphones,
          ),

          AudioPlayerWidget(
            audioPath: 'assets/audio/text.mp3',
            title: 'Sample Audio Narration',
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('What is Audio?'),
          _buildContentText(
              'Audio refers to sound content in digital form. It includes music, speech, '
                  'and sound effects that enhance user experience.'
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Audio Types'),
          _buildBulletPoint('Speech/Narration - Human voice recordings'),
          _buildBulletPoint('Music - Background scores and soundtracks'),
          _buildBulletPoint('Sound Effects - Environmental sounds'),

          const SizedBox(height: 20),

          _buildSectionTitle('Common Formats'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFormatChip('MP3'),
              _buildFormatChip('WAV'),
              _buildFormatChip('AAC'),
            ],
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
            message: '📹 Press play to watch video',
            icon: Icons.play_circle,
          ),

          // Video Player - Fixed with constraints
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: VideoPlayerWidget(
              videoPath: 'assets/videos/sample.mp4',
            ),
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('About Video'),
          _buildContentText(
              'Video combines moving images with audio to deliver rich multimedia content.'
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Video Characteristics'),
          _buildBulletPoint('Frame Rate - Typically 24, 30, or 60 fps'),
          _buildBulletPoint('Resolution - HD, 4K quality'),
          _buildBulletPoint('Codec - H.264, VP9 compression'),
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
            message: '✨ Watch the shape animate automatically',
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
              'Animation creates the illusion of motion through sequential images.'
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Animation Types'),
          _buildBulletPoint('2D Animation - Flat animation'),
          _buildBulletPoint('3D Animation - Three-dimensional'),
          _buildBulletPoint('Motion Graphics - Animated design'),
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
            message: '🎨 Tap anywhere on the interactive area to create graphics!',
            icon: Icons.touch_app,
          ),

          // Interactive Graphics Demo - Fixed height
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 300,
            ),
            child: const InteractiveGraphicsDemo(),
          ),

          const SizedBox(height: 20),

          // Image Gallery
          _buildSectionTitle('Image Examples'),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildImageCard('multimedia.png'),
                _buildImageCard('audio.png'),
                _buildImageCard('video.png'),
              ],
            ),
          ),

          const SizedBox(height: 20),

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

          _buildSectionTitle('Common Formats'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFormatChip('JPEG'),
              _buildFormatChip('PNG'),
              _buildFormatChip('SVG'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imageName) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/$imageName',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 40, color: Colors.grey.shade400),
                  const SizedBox(height: 8),
                  Text(
                    imageName,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGraphicExample(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, size: 35, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
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
      label: Text(format, style: const TextStyle(fontSize: 12)),
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
            child: Text(example, style: const TextStyle(fontSize: 15)),
          )),
        ],
      ),
    );
  }
}