import 'package:flutter/material.dart';
import '../widgets/audio_player_widget.dart';
import '../widgets/animated_card.dart';
import '../widgets/interactive_graphics_demo.dart';

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

          _buildSectionTitle('Applications'),
          _buildContentText(
              'Text is used in menus, captions, subtitles, instructions, hyperlinks, and informational displays.'
          ),

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
          _buildFormatChip('MP3'),
          _buildFormatChip('WAV'),
          _buildFormatChip('AAC'),
          _buildFormatChip('OGG'),
          _buildFormatChip('FLAC'),
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

          // Video Placeholder
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.black54],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_outline, size: 60, color: Colors.white),
                  const SizedBox(height: 10),
                  const Text(
                    'Video Demo',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Place video file in assets/videos/',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
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
          _buildFormatChip('MP4'),
          _buildFormatChip('AVI'),
          _buildFormatChip('MOV'),
          _buildFormatChip('MKV'),
          _buildFormatChip('WebM'),
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

          // Animation Demo
          Center(
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
                      gradient: LinearGradient(
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
          _buildBulletPoint('Timing and Spacing'),
          _buildBulletPoint('Ease In/Ease Out'),
          _buildBulletPoint('Anticipation and Follow-through'),
          _buildBulletPoint('Squash and Stretch'),
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
          // NEW: Interactive Graphics Demo
          const InteractiveGraphicsDemo(),

          const SizedBox(height: 20),

          // Interactive Image Gallery
          _buildImageGallery(),

          const SizedBox(height: 20),

          // Graphics Demo
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

          _buildSectionTitle('Types of Graphics'),
          _buildBulletPoint('Raster Graphics - Pixel-based (JPEG, PNG)'),
          _buildBulletPoint('Vector Graphics - Path-based (SVG, AI)'),
          _buildBulletPoint('3D Graphics - Three-dimensional models'),
          _buildBulletPoint('Infographics - Data visualization'),

          const SizedBox(height: 20),

          _buildSectionTitle('Common Image Formats'),
          _buildFormatChip('JPEG'),
          _buildFormatChip('PNG'),
          _buildFormatChip('GIF'),
          _buildFormatChip('SVG'),
          _buildFormatChip('WebP'),

          const SizedBox(height: 20),

          _buildSectionTitle('Applications'),
          _buildContentText(
              'Graphics are used in logos, icons, photographs, illustrations, charts, diagrams, and user interfaces.'
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    final images = ['education.jpg', 'tech.jpg', 'multimedia.jpg'];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/${images[index]}',
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 300,
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image, size: 60, color: Colors.grey),
                                    SizedBox(height: 8),
                                    Text('Image not found'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/${images[index]}',
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
                              images[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
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
          ),
          child: Icon(icon, size: 40, color: color),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
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
            'â¢ ',
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
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: Chip(
        label: Text(format),
        backgroundColor: Colors.grey.shade200,
      ),
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