import 'package:animevn/model/episode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListEpisode extends StatefulWidget {
  const ListEpisode({super.key, required this.inputdata, required this.onLinkSelected});

  final List<EpisodeData> inputdata;
  final Function(String) onLinkSelected;

  @override
  State<ListEpisode> createState() => _ListEpisodeState();
}

class _ListEpisodeState extends State<ListEpisode> {
  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        childAspectRatio: 3 / 4,
      ),
      itemCount: widget.inputdata.length,
      itemBuilder: (context, index) {
        final String link = widget.inputdata[index].linkEmbed;
        return Padding(
            padding: EdgeInsets.all(2),
            child: InkWell(
                onTap: () {
                  widget.onLinkSelected(link);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.amber),
                  child: Text(widget.inputdata[index].slug),
                )));
      },
    );
  }
}
