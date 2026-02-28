import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'intro_screen.dart';
import 'elements_screen.dart';
import 'demo_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A237E),
              const Color(0xFF283593),
              const Color(0xFF3949AB),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 60),

              // App Logo/Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.school,
                  size: 60,
                  color: Color(0xFF1A237E),
                ),
              ),

              const SizedBox(height: 30),

              // Animated Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Multimedia Learning Companion',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Explore Text, Audio, Video, Animation & Graphics',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 50),

              // Navigation Cards
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildNavigationCard(
                      context,
                      icon: Icons.info_outline,
                      title: 'Introduction to Multimedia',
                      description: 'Learn the fundamentals of multimedia systems',
                      color: const Color(0xFF00897B),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const IntroScreen()),
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildNavigationCard(
                      context,
                      icon: Icons.library_books,
                      title: 'Elements of Multimedia',
                      description: 'Discover text, audio, video, animation & graphics',
                      color: const Color(0xFFD32F2F),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ElementsScreen()),
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildNavigationCard(
                      context,
                      icon: Icons.play_circle_filled,
                      title: 'Interactive Demo',
                      description: 'Experience multimedia elements in action',
                      color: const Color(0xFFF57C00),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DemoScreen()),
                      ),
                    ),

                    const SizedBox(height: 30),
                    const SizedBox(height: 16),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required Color color,
        required VoidCallback onTap,
      }) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black45,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                color,
                color.withOpacity(0.8),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}