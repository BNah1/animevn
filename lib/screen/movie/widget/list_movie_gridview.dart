import 'package:animevn/bloc/movie/movie_bloc.dart';
import 'package:animevn/bloc/movie/movie_event.dart';
import 'package:animevn/bloc/movie/movie_state.dart';
import 'package:animevn/screen/movie/movie_screen.dart';
import 'package:animevn/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/movie_tile_homepage.dart';

class ListMovieGridView extends StatefulWidget {
  const ListMovieGridView({super.key});

  @override
  State<ListMovieGridView> createState() => _ListMovieGridViewState();
}

class _ListMovieGridViewState extends State<ListMovieGridView> {
  String link = 'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=1';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieBloc()..add(LoadApiResponseWithPage(link)),
      child: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
        if (state is MovieLoading) {
          return const Loader();
        } else if (state is MovieError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is ApiLoaded) {
          return Column(
            children: [
              Text('Page 1'),
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 2,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: state.listApi.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(2),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, MovieScreen.routerName,
                                  arguments: state.listApi[index].slug);
                            },
                            child: MovieTileHomepage(
                              name: state.listApi[index].name,
                              posterUrl: state.listApi[index].posterUrl,
                              height: 200,
                              widght: 150,
                            )));
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      }),
    );
  }
}
