import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieTileHomepage extends StatelessWidget {
  const MovieTileHomepage({super.key, required this.name, required this.posterUrl, this.height, this.widght});

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
            title: Text(name),
            subtitle: Text('xxxxx'),
          ),
          child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(posterUrl),
          )),
    );
  }
}
