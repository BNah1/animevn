import 'package:animevn/constant/const.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:animevn/screen/movie/widget/list_episode.dart';
import 'package:animevn/screen/videoplayer/widget/network_video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoplayerScreen extends StatefulWidget {
  const VideoplayerScreen({super.key, required this.apiData});
  final ApiResponse apiData;
  static const routerName = '/videoplayer';

  @override
  State<VideoplayerScreen> createState() => _VideoplayerScreenState();
}


class _VideoplayerScreenState extends State<VideoplayerScreen> {
  late String link;

  @override
  void initState() {
    link = widget.apiData.episodes.serverData[0].linkEmbed;
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
      appBar: AppBar(title: Text(widget.apiData.movie.name, style: styleTile,),),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
                child: NetworkVideoView(videoUrl: link)),
            SizedBox(height: 10,),
            Text('Chon Sever :'),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration( borderRadius: BorderRadius.circular(5),color: Colors.amber),child: Center(child: Text(widget.apiData.episodes.serverName)),),
            SizedBox(height: 10,),
            Text('Danh sach tap :'),
            ListEpisode(inputdata: widget.apiData.episodes.serverData, onLinkSelected: _updateLink),
          ],
        ),
      ),
    );
  }
}
