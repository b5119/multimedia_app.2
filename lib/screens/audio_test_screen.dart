import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioTestScreen extends StatefulWidget {
  const AudioTestScreen({super.key});

  @override
  State<AudioTestScreen> createState() => _AudioTestScreenState();
}

class _AudioTestScreenState extends State<AudioTestScreen> {
  final AudioPlayer _player = AudioPlayer();
  String _status = 'Ready to test';
  bool _isPlaying = false;

  Future<void> _testAudio() async {
    try {
      setState(() => _status = 'Loading intro.mp3...');

      await _player.setAsset('assets/audio/intro.mp3');

      setState(() => _status = 'Loaded! Duration: ${_player.duration}\nPress Play to hear it');

    } catch (e) {
      setState(() => _status = 'ERROR: $e');
    }
  }

  Future<void> _play() async {
    try {
      await _player.play();
      setState(() {
        _isPlaying = true;
        _status = 'Playing audio!';
      });
    } catch (e) {
      setState(() => _status = 'Play ERROR: $e');
    }
  }

  Future<void> _stop() async {
    await _player.stop();
    setState(() {
      _isPlaying = false;
      _status = 'Stopped';
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Debug Test'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.audiotrack, size: 80, color: Colors.purple),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _status,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: _testAudio,
                icon: const Icon(Icons.refresh),
                label: const Text('Load Audio'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: _play,
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                label: Text(_isPlaying ? 'Pause' : 'Play'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: _stop,
                icon: const Icon(Icons.stop),
                label: const Text('Stop'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Instructions:\n'
                    '1. Press "Load Audio"\n'
                    '2. If successful, press "Play"\n'
                    '3. You should hear audio!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}