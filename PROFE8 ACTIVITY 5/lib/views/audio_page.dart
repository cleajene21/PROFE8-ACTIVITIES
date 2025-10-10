import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isStopped = true;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    // Listen for audio position changes
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() => _position = position);
    });

    // Listen for audio duration changes
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() => _duration = duration);
    });

    // Listen for player state changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
        _isStopped = state == PlayerState.stopped;
      });
    });

    // Listen for completion
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        _isStopped = true;
        _position = Duration.zero;
      });
    });
  }

  Future<void> _playAudio() async {
    try {
      if (_isStopped) {
        await _audioPlayer.play(AssetSource('audio/audio.mp3'));
      } else {
        await _audioPlayer.resume();
      }
      setState(() {
        _isStopped = false;
      });
    } catch (e) {
      _showErrorSnackbar('Failed to play audio: $e');
    }
  }

  Future<void> _pauseAudio() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      _showErrorSnackbar('Failed to pause audio: $e');
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isStopped = true;
        _position = Duration.zero;
      });
    } catch (e) {
      _showErrorSnackbar('Failed to stop audio: $e');
    }
  }

  Future<void> _seekAudio(double value) async {
    try {
      final position =
          Duration(milliseconds: (value * _duration.inMilliseconds).toInt());
      await _audioPlayer.seek(position);
    } catch (e) {
      _showErrorSnackbar('Failed to seek audio: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Large Play/Pause Icon
              Icon(
                Icons.music_note,
                size: 80,
                color: Colors.pinkAccent.withOpacity(0.7),
              ),
              const SizedBox(height: 30),

              // Progress Bar
              Column(
                children: [
                  Slider(
                    value: _duration.inMilliseconds > 0
                        ? _position.inMilliseconds / _duration.inMilliseconds
                        : 0.0,
                    onChanged: _duration.inMilliseconds > 0 ? _seekAudio : null,
                    activeColor: Colors.pinkAccent,
                    inactiveColor: Colors.pinkAccent.withOpacity(0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(_position)),
                        Text(_formatDuration(_duration)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Stop Button
                  ElevatedButton.icon(
                    onPressed: _isPlaying || (!_isPlaying && !_isStopped)
                        ? _stopAudio
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    icon: const Icon(Icons.stop),
                    label: const Text('STOP'),
                  ),

                  // Play Button
                  ElevatedButton.icon(
                    onPressed: !_isPlaying ? _playAudio : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('PLAY'),
                  ),

                  // Pause Button
                  ElevatedButton.icon(
                    onPressed: _isPlaying ? _pauseAudio : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    icon: const Icon(Icons.pause),
                    label: const Text('PAUSE'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Quick Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Quick Play/Pause Button
                  IconButton(
                    iconSize: 60,
                    icon: Icon(
                      _isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: _isPlaying ? _pauseAudio : _playAudio,
                  ),
                ],
              ),

              // Status Text
              const SizedBox(height: 20),
              Text(
                _isStopped
                    ? 'Stopped'
                    : _isPlaying
                        ? 'Playing...'
                        : 'Paused',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _isPlaying ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
