import 'package:animevn/core/constant/const.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class MovieTileSearch extends StatelessWidget {
  const MovieTileSearch({super.key, required this.data});

  final ApiResponse data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 150,
              width: 100,
              child: CachedNetworkImage(imageUrl: 'https://phimimg.com//${data.posterUrl}')),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: styleTile,
                ),
                Text(data.year)
              ],
            ),
          )
        ],
      ),
    );
  }
}
