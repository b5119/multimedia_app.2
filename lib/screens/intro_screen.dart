import 'package:flutter/material.dart';
import '../widgets/audio_player_widget.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introduction to Multimedia'),
        elevation: 0,
        backgroundColor: const Color(0xFF00897B),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF00897B),
                    const Color(0xFF00897B).withOpacity(0.7),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Background image if exists
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        'assets/images/multimedia.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(),
                      ),
                    ),
                  ),
                  // Foreground content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.video_library,
                          size: 80,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'What is Multimedia?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Audio Player
            Padding(
              padding: const EdgeInsets.all(20),
              child: AudioPlayerWidget(
                audioPath: 'assets/audio/intro.mp3',
                title: 'Listen to Introduction',
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Definition'),
                  _buildContentText(
                      'Multimedia refers to the integration of multiple forms of media, including text, '
                          'audio, images, animations, and video into a single interactive experience. '
                          'It combines various content forms to present information in a rich and engaging way.'
                  ),

                  const SizedBox(height: 30),

                  _buildSectionTitle('Key Characteristics'),
                  _buildBulletPoint('Integration of multiple media types'),
                  _buildBulletPoint('Interactive user experience'),
                  _buildBulletPoint('Digital content delivery'),
                  _buildBulletPoint('Non-linear information flow'),
                  _buildBulletPoint('User-controlled navigation'),

                  const SizedBox(height: 30),

                  _buildSectionTitle('Historical Context'),
                  _buildContentText(
                      'The term "multimedia" emerged in the 1960s but gained prominence in the 1990s '
                          'with the rise of personal computers and CD-ROM technology. Today, multimedia '
                          'is ubiquitous in education, entertainment, communication, and business applications.'
                  ),

                  const SizedBox(height: 30),

                  _buildInfoCard(
                    icon: Icons.lightbulb_outline,
                    title: 'Did You Know?',
                    content: 'The human brain processes visual information 60,000 times faster than text, '
                        'making multimedia an extremely effective learning tool.',
                    color: Colors.amber.shade700,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
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
          color: Color(0xFF00897B),
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
              color: Color(0xFF00897B),
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
          Icon(icon, color: color, size: 30),
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