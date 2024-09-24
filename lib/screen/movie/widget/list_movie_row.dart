import 'package:animevn/model/movie.dart';
import 'package:animevn/widget/movie_tile_homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/const.dart';
import '../movie_screen.dart';

class ListMovieRow extends StatefulWidget {
  const ListMovieRow({super.key, required this.inputdata, required this.title});
  final String title;
  final Future<List<Movie>> inputdata;

  @override
  State<ListMovieRow> createState() => _ListMovieRowState();
}

class _ListMovieRowState extends State<ListMovieRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.title,
                style: styleTile,
              )),
          FutureBuilder(
            future: widget.inputdata,
            initialData: [],
            builder: (context, asyncData) {
              var data = [];
              if (asyncData.hasData) {
                data = asyncData.data! as List;
              } else {
                Container(child: const Text('nodata'));
              }
              return SizedBox(
                height: 230,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                          Navigator.pushNamed(context, MovieScreen.routerName,
                              arguments: data[index]);
                      },
                      child: MovieTileHomepage(name: data[index].name, posterUrl: data[index].posterUrl, height: 200, widght: 150,)
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                ),
              );
            },
          ),
        ]);
  }
}
