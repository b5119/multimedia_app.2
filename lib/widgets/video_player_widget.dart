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
        setState(() => _isInitialized = true);
      }
    } catch (e) {
      print('Video error: $e');
      if (mounted) {
        setState(() => _hasError = true);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildError() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.black87, Colors.black54]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.videocam_off, size: 40, color: Colors.white70),
            SizedBox(height: 8),
            Text(
              'Video not found',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Add video to assets/videos/sample.mp4',
                style: TextStyle(color: Colors.white60, fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.black87, Colors.black54]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Restart
        IconButton(
          onPressed: () => setState(() {
            _controller!.seekTo(Duration.zero);
            _controller!.pause();
          }),
          icon: const Icon(Icons.replay, color: Colors.white70),
          tooltip: 'Restart',
        ),
        const SizedBox(width: 8),
        // Play / Pause
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFD32F2F),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => setState(() {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            }),
            icon: Icon(
              _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            iconSize: 28,
          ),
        ),
        const SizedBox(width: 8),
        // Forward 5s
        IconButton(
          onPressed: () {
            final pos = _controller!.value.position;
            final dur = _controller!.value.duration;
            final next = pos + const Duration(seconds: 5);
            if (next < dur) _controller!.seekTo(next);
          },
          icon: const Icon(Icons.forward_5, color: Colors.white70),
          tooltip: 'Forward 5s',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) return _buildError();
    if (!_isInitialized || _controller == null) return _buildLoading();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Video — Flexible so it shrinks to give room to controls below
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
          ),
        ),
        const SizedBox(height: 6),
        // Progress bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: VideoProgressIndicator(
            _controller!,
            allowScrubbing: true,
            padding: EdgeInsets.zero,
            colors: const VideoProgressColors(
              playedColor: Color(0xFFD32F2F),
              backgroundColor: Colors.grey,
              bufferedColor: Color(0xFFFFCDD2),
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Controls
        _buildControls(),
      ],
    );
  }
}