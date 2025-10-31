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
      this.width, this.isHome = false});

  final String posterUrl;
  final String name;
  final double? height;
  final double? width;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    const double padding = 5;
    return Container(
        padding: EdgeInsets.all(isHome ? 0 : padding),
        height: height,
        width: width,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: posterUrl,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
              ),
            ),
            Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  padding: const EdgeInsets.all(padding),
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: styleTileItem,
                  ),
                ))
          ],
        )

        );
  }
}
