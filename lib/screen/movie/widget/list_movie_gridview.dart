import 'package:animevn/model/movie.dart';
import 'package:animevn/screen/movie/movie_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widget/movie_tile_homepage.dart';

class ListMovieGridView extends StatefulWidget {
  const ListMovieGridView({super.key, required this.inputdata});

  final Future<List<Movie>> inputdata;

  @override
  State<ListMovieGridView> createState() => _ListMovieGridViewState();
}

class _ListMovieGridViewState extends State<ListMovieGridView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: widget.inputdata,
      builder: (context, snapshot) {
        var data = snapshot.data!;
        return GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 2,
            childAspectRatio: 3 / 4,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(2),
              child: InkWell(
                  onTap: (){
                    print(data[index]);
                    Navigator.pushNamed(context, MovieScreen.routerName,
                        arguments: data[index]);
                  },
                  child: MovieTileHomepage(name: data[index].name, posterUrl: data[index].posterUrl,))
            );
          },
        );
      },
    );
  }
}
