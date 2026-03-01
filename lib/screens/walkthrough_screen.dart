import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math' as math;
import 'home_screen.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen>
    with TickerProviderStateMixin {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isAudioPlaying = false;

  // Animation controllers
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _pulseController;

  // Graphics interaction
  final List<TapEffect> _tapEffects = [];
  bool _hasInteractedWithGraphics = false;

  final List<WalkthroughStep> _steps = [
    WalkthroughStep(
      title: 'Welcome to\nMultimedia',
      subtitle: 'Let\'s explore the 5 core elements',
      icon: Icons.school,
      color: Color(0xFF667eea),
      type: StepType.intro,
    ),
    WalkthroughStep(
      title: 'Element 1:\nText',
      subtitle: 'The foundation of digital communication',
      icon: Icons.text_fields,
      color: Color(0xFF1976D2),
      type: StepType.text,
    ),
    WalkthroughStep(
      title: 'Element 2:\nAudio',
      subtitle: 'Listen as audio plays automatically',
      icon: Icons.audiotrack,
      color: Color(0xFF7B1FA2),
      type: StepType.audio,
      audioPath: 'assets/audio/intro.mp3',
    ),
    WalkthroughStep(
      title: 'Element 3:\nGraphics',
      subtitle: 'Visual elements and images',
      icon: Icons.palette,
      color: Color(0xFF00897B),
      type: StepType.graphics,
    ),
    WalkthroughStep(
      title: 'Element 4:\nAnimation',
      subtitle: 'Watch elements come alive',
      icon: Icons.animation,
      color: Color(0xFFF57C00),
      type: StepType.animation,
    ),
    WalkthroughStep(
      title: 'Element 5:\nVideo',
      subtitle: 'Moving pictures',
      icon: Icons.videocam,
      color: Color(0xFFD32F2F),
      type: StepType.video,
    ),
    WalkthroughStep(
      title: 'All Elements\nCombined!',
      subtitle: 'Complete multimedia integration',
      icon: Icons.auto_awesome,
      color: Color(0xFF4CAF50),
      type: StepType.complete,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _rotationController.dispose();
    _scaleController.dispose();
    _pulseController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String audioPath) async {
    try {
      await _audioPlayer.setAsset(audioPath);
      await _audioPlayer.play();
      setState(() => _isAudioPlaying = true);

      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() => _isAudioPlaying = false);
        }
      });
    } catch (e) {
      print('Audio error: $e');
    }
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });

      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      // Auto-play audio
      if (_steps[_currentStep].type == StepType.audio) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (_steps[_currentStep].audioPath != null) {
            _playAudio(_steps[_currentStep].audioPath!);
          }
        });
      }

      // Start animations
      if (_steps[_currentStep].type == StepType.animation) {
        _rotationController.repeat();
      }

      // Reset graphics
      if (_steps[_currentStep].type == StepType.graphics) {
        setState(() {
          _hasInteractedWithGraphics = false;
        });
      }
    } else {
      // FINISH - GO TO HOME SCREEN
      _audioPlayer.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _audioPlayer.stop();
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _addTapEffect(Offset position) {
    setState(() {
      _hasInteractedWithGraphics = true;
      _tapEffects.add(TapEffect(
        position: position,
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        time: DateTime.now(),
      ));

      if (_tapEffects.length > 10) {
        _tapEffects.removeAt(0);
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && _tapEffects.isNotEmpty) {
        setState(() {
          _tapEffects.removeWhere((tap) => tap.time == _tapEffects.first.time);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentStepData = _steps[_currentStep];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              currentStepData.color,
              currentStepData.color.withOpacity(0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Progress bar
              _buildProgressBar(),

              // Main content - FIXED WITH FLEXIBLE
              Flexible(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _steps.length,
                  itemBuilder: (context, index) {
                    return _buildStepContent(_steps[index]);
                  },
                ),
              ),

              // Navigation buttons
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${_currentStep + 1} of ${_steps.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${((_currentStep + 1) / _steps.length * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / _steps.length,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(WalkthroughStep step) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          _buildStepIcon(step),

          const SizedBox(height: 20),

          // Title
          Text(
            step.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          // Subtitle
          Text(
            step.subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Interactive content
          _buildInteractiveContent(step),
        ],
      ),
    );
  }

  Widget _buildStepIcon(WalkthroughStep step) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 100,
            height: 100,
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
            child: Icon(
              step.icon,
              size: 50,
              color: step.color,
            ),
          ),
        );
      },
    );
  }

  Widget _buildInteractiveContent(WalkthroughStep step) {
    switch (step.type) {
      case StepType.intro:
        return _buildIntroContent();
      case StepType.text:
        return _buildTextContent();
      case StepType.audio:
        return _buildAudioContent();
      case StepType.graphics:
        return _buildGraphicsContent();
      case StepType.animation:
        return _buildAnimationContent();
      case StepType.video:
        return _buildVideoContent();
      case StepType.complete:
        return _buildCompleteContent();
    }
  }

  Widget _buildIntroContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.touch_app, size: 50, color: Colors.white),
          SizedBox(height: 16),
          Text(
            'Press "Next" to begin\nyour journey',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Text Formatting',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Normal body text',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            'Bold text adds emphasis',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Colored text draws attention',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.15),
                child: Icon(
                  _isAudioPlaying ? Icons.volume_up : Icons.headphones,
                  size: 60,
                  color: Colors.white,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            _isAudioPlaying ? '🎵 Playing...' : '🎧 Ready',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Audio plays automatically',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGraphicsContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image Gallery
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildImagePreview('multimedia.jpg'),
              _buildImagePreview('audio.jpg'),
              _buildImagePreview('video.jpg'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Interactive area
        GestureDetector(
          onTapDown: (details) => _addTapEffect(details.localPosition),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
            ),
            child: Stack(
              children: [
                ..._tapEffects.map((effect) => _TapEffectWidget(effect: effect)),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.touch_app, size: 40, color: Colors.white),
                      const SizedBox(height: 12),
                      Text(
                        _hasInteractedWithGraphics ? '✨ Great!' : 'TAP HERE!',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildImagePreview(String imageName) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/$imageName',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.white.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image, color: Colors.white70, size: 30),
                  const SizedBox(height: 4),
                  Text(
                    imageName.split('.').first,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimationContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationController.value * 2 * math.pi,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Color(0xFFF57C00),
                        size: 30,
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _scaleController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 0.8 + (_scaleController.value * 0.4),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            '✨ 60fps Animations',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_circle_filled, size: 70, color: Colors.white),
          SizedBox(height: 20),
          Text(
            '📹 Video Capability',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Moving images with audio',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified,
            size: 70,
            color: Colors.green,
          ),
          const SizedBox(height: 20),
          const Text(
            'Multimedia\nMastered!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4CAF50),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _buildCheckItem('✓ Text'),
          _buildCheckItem('✓ Audio'),
          _buildCheckItem('✓ Graphics'),
          _buildCheckItem('✓ Animation'),
          _buildCheckItem('✓ Video'),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 20),
                    SizedBox(width: 6),
                    Text('Back', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),

          if (_currentStep > 0) const SizedBox(width: 12),

          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: _steps[_currentStep].color,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentStep == _steps.length - 1 ? 'Finish' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Supporting classes
enum StepType {
  intro,
  text,
  audio,
  graphics,
  animation,
  video,
  complete,
}

class WalkthroughStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final StepType type;
  final String? audioPath;

  WalkthroughStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.type,
    this.audioPath,
  });
}

class TapEffect {
  final Offset position;
  final Color color;
  final DateTime time;

  TapEffect({
    required this.position,
    required this.color,
    required this.time,
  });
}

class _TapEffectWidget extends StatefulWidget {
  final TapEffect effect;

  const _TapEffectWidget({required this.effect});

  @override
  State<_TapEffectWidget> createState() => _TapEffectWidgetState();
}

class _TapEffectWidgetState extends State<_TapEffectWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnim = Tween<double>(begin: 0.0, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: widget.effect.position.dx - 30,
          top: widget.effect.position.dy - 30,
          child: Opacity(
            opacity: _opacityAnim.value,
            child: Transform.scale(
              scale: _scaleAnim.value,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.effect.color.withOpacity(0.6),
                  boxShadow: [
                    BoxShadow(
                      color: widget.effect.color,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}