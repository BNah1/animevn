import 'package:animevn/model/episode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListEpisode extends StatefulWidget {
  const ListEpisode(
      {super.key, required this.inputdata, required this.onLinkSelected});

  final List<EpisodeData> inputdata;
  final Function(String) onLinkSelected;


  @override
  State<ListEpisode> createState() => _ListEpisodeState();
}

class _ListEpisodeState extends State<ListEpisode> {
  late String currentSelected;
  @override
  void initState() {
    currentSelected = widget.inputdata[0].slug;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        childAspectRatio: 1,
      ),
      itemCount: widget.inputdata.length,
      itemBuilder: (context, index) {
        final String link = widget.inputdata[index].link_m3u8;
        return InkWell(
            onTap: () {
              widget.onLinkSelected(link);
              currentSelected = widget.inputdata[index].slug;
            },
            child: Padding(
              padding: EdgeInsets.all(1),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: widget.inputdata[index].slug == currentSelected ? Colors.grey : Colors.amber),
                child: Center(child: Text(widget.inputdata[index].slug)),
              ),
            ));
      },
    );
  }
}
