import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import '../../../../core/constant/const.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  const FullScreenVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.currentPosition,
    required this.isPlaying
  }) : super(key: key);

  final String videoUrl;
  final Duration currentPosition;
  final bool isPlaying;

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  bool _isFabVisible = true; // Biến điều khiển sự hiển thị của FloatingActionButton
  Timer? _hideFabTimer; // Biến Timer để ẩn FAB
  late bool isPlaying;

  @override
  void initState() {
    isPlaying = widget.isPlaying;
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {

          _videoPlayerController.seekTo(widget.currentPosition);

          if (isPlaying) {
            _videoPlayerController.play();
          } else {
            _videoPlayerController.pause();
          }

          _startHideFabTimer(); // Bắt đầu timer fab
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
    _hideFabTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _isFabVisible = false; // Ẩn FAB
      });
    });
  }

  void _showFab() {
    setState(() {
      _isFabVisible = true; // Hiển thị lại FAB
    });
    _startHideFabTimer(); // Bắt đầu timer fab
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
                      colors: const VideoProgressColors(
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
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            // Nút phóng to
                            IconButton(
                              icon: const Icon(Icons.fullscreen, color: Colors.white),
                              onPressed: () async {
                                _videoPlayerController.pause();
                                _videoPlayerController.dispose();
                                Navigator.pop(context, {
                                  'position': _videoPlayerController.value.position,
                                  'isPlaying': isPlaying,
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ): const SizedBox(),
            ]
          ),
        ),
      ),
    );
  }
}
