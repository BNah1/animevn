import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import '../../../constant/const.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  const FullScreenVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.currentPosition,
  }) : super(key: key);

  final String videoUrl;
  final Duration currentPosition;

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  bool _isFabVisible = true; // Biến điều khiển sự hiển thị của FloatingActionButton
  Timer? _hideFabTimer; // Biến Timer để ẩn FAB
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController.seekTo(widget.currentPosition);
          _videoPlayerController.play(); // Bắt đầu phát video
          _startHideFabTimer(); // Bắt đầu timer để ẩn FAB
        });
      });
  }

  @override
  void dispose() {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _hideFabTimer?.cancel(); // Hủy timer
    super.dispose();
  }

  void _startHideFabTimer() {
    _hideFabTimer?.cancel();
    _hideFabTimer = Timer(Duration(seconds: 3), () {
      setState(() {
        _isFabVisible = false; // Ẩn FAB
      });
    });
  }

  void _showFab() {
    setState(() {
      _isFabVisible = true; // Hiển thị lại FAB
    });
    _startHideFabTimer(); // Bắt đầu lại timer
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showFab, // Hiển thị FAB khi chạm vào màn hình
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(_videoPlayerController),
            ),
              _isFabVisible ? Positioned(
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
                        final totalDuration = _videoPlayerController
                            .value.duration.inSeconds >
                            0
                            ? formatDuration(_videoPlayerController.value.duration)
                            : '00:00';

                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPlaying = !isPlaying;
                                  isPlaying
                                      ? _videoPlayerController.play()
                                      : _videoPlayerController.pause();
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
                            Spacer(),
                            // Nút phóng to
                            IconButton(
                              icon: Icon(Icons.fullscreen, color: Colors.white),
                              onPressed: () {
                                _videoPlayerController.pause();
                                _videoPlayerController.dispose();
                                Navigator.pop(context, _videoPlayerController.value.position);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ): SizedBox(),
            ]
          ),
        ),
      ),
    );
  }
}
