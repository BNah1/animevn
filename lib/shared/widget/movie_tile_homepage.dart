import 'package:animevn/core/constant/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieTileHomepage extends StatelessWidget {
  const MovieTileHomepage(
      {super.key,
      required this.name,
      required this.posterUrl,
      this.height,
      this.widght});

  final String posterUrl;
  final String name;
  final double? height;
  final double? widght;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: widght,
      child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black26,
            title: Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: styleTileItem,
            ),
          ),
          child: CachedNetworkImage(imageUrl: posterUrl,
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
              ),
            ),)),
    );
  }
}
