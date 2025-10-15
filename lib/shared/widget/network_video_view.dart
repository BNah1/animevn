import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../core/constant/const.dart';

class NetworkVideoView extends StatefulWidget {
  const NetworkVideoView({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<NetworkVideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<NetworkVideoView> {
  late final VideoPlayerController _videoPlayerController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        //  autoplay neu can
        // _videoPlayerController.play();
      }).catchError((error) {
        print("Error loading video: $error");
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoPlayerController.value.isInitialized
          ? _videoPlayerController.value.aspectRatio
          : 16 / 9,
      child: Stack(
        children: [
          VideoPlayer(_videoPlayerController),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VideoProgressIndicator(
                  _videoPlayerController,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.grey,
                    backgroundColor: Colors.black54,
                  ),
                ),
                ValueListenableBuilder<VideoPlayerValue>(
                  valueListenable: _videoPlayerController,
                  builder: (context, value, child) {
                    final currentPosition = formatDuration(value.position);
                    final totalDuration = _videoPlayerController.value.duration.inSeconds > 0
                        ? formatDuration(_videoPlayerController.value.duration)
                        : '00:00';

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPlaying = !isPlaying;
                              isPlaying ? _videoPlayerController.play() : _videoPlayerController.pause();
                            });
                          },
                          child: Center(
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '$currentPosition / $totalDuration',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}