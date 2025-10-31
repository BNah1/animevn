import 'package:animevn/core/bloc/movie/movie_bloc.dart';
import 'package:animevn/core/bloc/movie/movie_event.dart';
import 'package:animevn/core/bloc/movie/movie_state.dart';
import 'package:animevn/shared/widget/movie_tile_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/const.dart';
import '../../../../shared/widget/loading.dart';
import '../../../movie/presentation/view/movie_screen.dart';

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
  void dispose() {
    print('ListMovieRow dispose');
    super.dispose();
  }

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
                          horizontal: 10, vertical: 15),
                      child: Text(
                        widget.title,
                        style: styleTile,
                      )),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (BuildContext context, int index) {
                        final bloc = context.read<MovieBloc>();
                        final pathImage = widget.isPage == true
                            ? state.listApi[index].posterUrl
                            : 'https://phimimg.com/${state.listApi[index].posterUrl}';
                        return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MovieScreen.routerName,
                                arguments: {
                                  'slug': state.listApi[index].slug,
                                  'bloc': bloc,
                                  'pathImage': pathImage,
                                },
                              );
                            },
                            child: MovieTileHomepage(
                              name: state.listApi[index].name,
                              posterUrl: pathImage,
                              width: 120,
                              isHome: true,
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
