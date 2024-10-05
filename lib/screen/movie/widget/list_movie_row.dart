import 'package:animevn/bloc/movie/movie_bloc.dart';
import 'package:animevn/bloc/movie/movie_event.dart';
import 'package:animevn/bloc/movie/movie_state.dart';
import 'package:animevn/widget/movie_tile_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/const.dart';
import '../../../widget/loading.dart';
import '../movie_screen.dart';

class ListMovieRow extends StatefulWidget {
  const ListMovieRow(
      {super.key,
      required this.title,
      required this.link,
      required this.isPage});

  final String title;
  final String link;
  final bool isPage;

  @override
  State<ListMovieRow> createState() => _ListMovieRowState();
}

class _ListMovieRowState extends State<ListMovieRow> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MovieBloc()
          ..add(widget.isPage == true
              ? LoadApiResponseWithPage(widget.link)
              : LoadApiResponse(widget.link)),
        child: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
          if (state is MovieLoading) {
            return const Loader();
          } else if (state is MovieError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ApiLoaded) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Text(
                        widget.title,
                        style: styleTile,
                      )),
                  SizedBox(
                    height: 230,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, MovieScreen.routerName,
                                  arguments: state.listApi[index].slug);
                            },
                            child: MovieTileHomepage(
                              name: state.listApi[index].name,
                              posterUrl: widget.isPage == true
                                  ? state.listApi[index].posterUrl
                                  : 'https://phimimg.com/${state.listApi[index].posterUrl}',
                              height: 200,
                              widght: 150,
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: state.listApi.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  )
                ]);
          }
          return Container();
        }));
  }
}
