import 'package:flutter/material.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class VideoPlayerContainer extends StatefulWidget {
  final String videoUrl; // URL or asset path of the video to be played
  final bool autoPlay;   // Option to start playing automatically
  final bool looping;    // Option to loop the video

  const VideoPlayerContainer({
    Key? key,
    required this.videoUrl,
    this.autoPlay = false,
    this.looping = false,
  }) : super(key: key);

  @override
  State<VideoPlayerContainer> createState() => _VideoPlayerContainerState();
}

class _VideoPlayerContainerState extends State<VideoPlayerContainer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    if (widget.videoUrl.startsWith('http')) {
      // Load video from network
      _controller = VideoPlayerController.network(widget.videoUrl);
    } else {
      // Load video from assets
      _controller = VideoPlayerController.asset(widget.videoUrl);
    }

    _initializeVideoPlayerFuture = _controller.initialize();
    if (widget.autoPlay) {
      _controller.play();
    }
    _controller.setLooping(widget.looping);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
