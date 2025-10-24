import 'package:animevn/core/constant/const.dart';
import 'package:animevn/feature/video_play/presentation/widget/list_episode.dart';
import 'package:flutter/material.dart';

import '../../../../model/movie.dart';
import '../widget/network_video_view.dart';

class VideoplayerScreen extends StatefulWidget {
  const VideoplayerScreen({super.key, required this.movie});
  final Movie movie;
  static const routerName = '/videoplayer';

  @override
  State<VideoplayerScreen> createState() => _VideoplayerScreenState();
}


class _VideoplayerScreenState extends State<VideoplayerScreen> {
  late String link;
  late int currentChap;

  @override
  void initState() {
    link = widget.movie.episodes.serverData[0].link_m3u8;
    print('asdasd' + widget.movie.episodes.serverName);
    super.initState();
  }

  void _updateLink(String data) {
    setState(() {
      link = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(widget.movie.name, style: styleTile,),),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: NetworkVideoView(videoUrl: link, slug: widget.movie.slug,)),
            SizedBox(height: 10,),
            Text('Chon Sever :'),
            Padding(
              padding: EdgeInsets.only(right: 200),
              child: Container(
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(5),color: Colors.amber),child: Center(
                child: Text(
                  widget.movie.episodes.serverName,
                  style: TextStyle(fontSize: 16),
                ),
              ),),
            ),
            SizedBox(height: 10,),
            Text('Danh sach tap :'),
            ListEpisode(inputdata: widget.movie.episodes.serverData, onLinkSelected: _updateLink),
          ],
        ),
      ),
    );
  }
}
