import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'dart:async'; 

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
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoPlayer(_videoPlayerController),
          ),
        ),
        floatingActionButton: _isFabVisible
            ? FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
            _videoPlayerController.pause();
            _videoPlayerController.dispose();
          },
          child: Icon(Icons.fullscreen_exit),
        )
            : null, // Nếu không hiển thị FAB, trả về null
      ),
    );
  }
}
