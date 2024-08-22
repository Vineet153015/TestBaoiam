
import 'package:flutter/material.dart';
import 'package:testbaoiam/ReusableComponents/VideoPlayer.dart';


class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  String assetVideoPath = "assets/videos/sample.mp4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoPlayerContainer(
        videoUrl: assetVideoPath,
        autoPlay: true,
        looping: false,
      ),
    );
  }
}
