import 'package:animevn/constant/const.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:flutter/cupertino.dart';

class MovieTileSearch extends StatelessWidget {
  const MovieTileSearch({super.key, required this.data});

  final ApiResponse data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 150,
              width: 100,
              child: Image.network(
                'https://phimimg.com//${data.posterUrl}',
                fit: BoxFit.cover,
              )),
          SizedBox(width: 10,),
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
