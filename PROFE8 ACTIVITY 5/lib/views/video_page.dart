import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    _controller = VideoPlayerController.asset('assets/videos/demo.mp4')
      ..initialize().then((_) {
        setState(() => _isInitialized = true);
      });
  }

  void _playVideo() {
    setState(() {
      _controller.play();
    });
  }

  void _pauseVideo() {
    setState(() {
      _controller.pause();
    });
  }

  void _stopVideo() {
    setState(() {
      _controller.pause();
      _controller.seekTo(Duration.zero);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Video Player'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(color: Colors.pinkAccent),
            ),
          ),
          // Custom controls container
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Play Button
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _playVideo : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play'),
                ),
                // Pause Button
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _pauseVideo : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.pause),
                  label: const Text('Pause'),
                ),
                // Stop Button
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _stopVideo : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.stop),
                  label: const Text('Stop'),
                ),
              ],
            ),
          ),
        ],
      ),
      // Keep the floating action button as well for quick access
      floatingActionButton: _isInitialized
          ? FloatingActionButton(
              backgroundColor: Colors.pinkAccent,
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
