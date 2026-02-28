import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({
    super.key,
    required this.videoPath,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;
  bool _hasError = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.videoPath);
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      constraints: BoxConstraints(
        maxWidth: screenWidth - 40,
        maxHeight: 300,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Video display area
          Container(
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildVideoContent(),
            ),
          ),

          const SizedBox(height: 12),

          // Controls
          if (_isInitialized && !_hasError) _buildControls(),

          // Helpful hint
          if (!_hasError)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    'Tap play to watch video',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoContent() {
    if (_hasError) {
      return Container(
        height: 200,
        color: Colors.black87,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.videocam_off, size: 50, color: Colors.white70),
              SizedBox(height: 10),
              Text(
                'Video not available',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Add video to assets/videos/sample.mp4',
                  style: TextStyle(color: Colors.white60, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return Container(
        height: 200,
        color: Colors.black87,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 15),
              Text(
                'Loading video...',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: _controller!.value.size.width,
          height: _controller!.value.size.height,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _controller!.seekTo(Duration.zero);
                    _controller!.pause();
                  });
                },
                icon: const Icon(Icons.replay),
                color: Colors.grey.shade700,
                tooltip: 'Restart',
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD32F2F),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD32F2F).withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller!.value.isPlaying
                          ? _controller!.pause()
                          : _controller!.play();
                    });
                  },
                  icon: Icon(
                    _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  iconSize: 32,
                  tooltip: _controller!.value.isPlaying ? 'Pause' : 'Play',
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  final currentPos = _controller!.value.position;
                  final duration = _controller!.value.duration;
                  final newPos = currentPos + const Duration(seconds: 5);
                  if (newPos < duration) {
                    _controller!.seekTo(newPos);
                  }
                },
                icon: const Icon(Icons.forward_5),
                color: Colors.grey.shade700,
                tooltip: 'Forward 5s',
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Progress bar with proper constraints
          SizedBox(
            height: 20,
            child: VideoProgressIndicator(
              _controller!,
              allowScrubbing: true,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              colors: const VideoProgressColors(
                playedColor: Color(0xFFD32F2F),
                backgroundColor: Colors.grey,
                bufferedColor: Color(0xFFFFCDD2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}