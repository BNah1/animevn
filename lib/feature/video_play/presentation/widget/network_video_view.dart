import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'fullscreen_videoplayer.dart';

class NetworkVideoView extends StatefulWidget {
  const NetworkVideoView(
      {super.key,
      required this.videoUrl,
      required this.slug,
      this.duration = Duration.zero});

  final String slug;
  final String videoUrl;
  final Duration duration;

  @override
  State<NetworkVideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<NetworkVideoView> {
  VideoPlayerController? _videoPlayerController;
  bool isPlaying = false;

  // Khởi tạo video controller
  void initializeVideo() {
    if (_videoPlayerController != null) {
      return;
    }

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      }).catchError((error) {
        print("Lỗi khi tải video: $error");
      });
  }

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  @override
  void didUpdateWidget(NetworkVideoView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Nếu videoUrl thay đổi, khởi tạo một VideoPlayerController mới
    if (oldWidget.videoUrl != widget.videoUrl) {
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
      initializeVideo();
    }

    if (oldWidget.duration != widget.duration) {
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
      _videoPlayerController!.seekTo(widget.duration);
      _videoPlayerController!.play();
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoPlayerController?.value.isInitialized == true
          ? _videoPlayerController!.value.aspectRatio
          : 16 / 9,
      child: Stack(
        children: [
          if (_videoPlayerController?.value.isInitialized == true)
            VideoPlayer(_videoPlayerController!),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VideoProgressIndicator(
                  _videoPlayerController!,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.grey,
                    backgroundColor: Colors.black54,
                  ),
                ),
                ValueListenableBuilder<VideoPlayerValue>(
                  valueListenable: _videoPlayerController!,
                  builder: (context, value, child) {
                    final currentPosition = formatDuration(value.position);
                    final totalDuration = _videoPlayerController!
                                .value.duration.inSeconds >
                            0
                        ? formatDuration(_videoPlayerController!.value.duration)
                        : '00:00';

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPlaying = !isPlaying;
                              isPlaying
                                  ? _videoPlayerController!.play()
                                  : _videoPlayerController!.pause();
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
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Spacer(),
                        // Nút phóng to
                        IconButton(
                          icon: const Icon(Icons.fullscreen, color: Colors.white),
                          onPressed: () {
                            _goToFullScreen(context);
                          },
                        ),
                      ],
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

  void _goToFullScreen(BuildContext context) {
    _videoPlayerController?.pause();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPlayer(
          videoUrl: widget.videoUrl,
          currentPosition:
              _videoPlayerController?.value.position ?? Duration.zero,
          isPlaying: isPlaying,
        ),
      ),
    ).then((result) {
      if (result != null) {
        Duration newPosition = result['position'];
        bool isPlaying = result['isPlaying'];

        setState(() {
          _videoPlayerController?.seekTo(newPosition);
          if (isPlaying) {
            _videoPlayerController?.play();
          } else {
            _videoPlayerController?.pause();
          }
        });
      }

    });
  }

  // Hàm hỗ trợ để định dạng thời gian
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
