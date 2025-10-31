import 'package:animevn/core/bloc/movie/movie_bloc.dart';
import 'package:animevn/core/bloc/movie/movie_event.dart';
import 'package:animevn/core/bloc/movie/movie_state.dart';
import 'package:animevn/feature/movie/presentation/view/movie_screen.dart';
import 'package:animevn/shared/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widget/movie_tile_homepage.dart';

class ListMovieGridView extends StatefulWidget {
  const ListMovieGridView({super.key, required this.page});
  final int page;

  @override
  State<ListMovieGridView> createState() => _ListMovieGridViewState();
}

class _ListMovieGridViewState extends State<ListMovieGridView> {
  late String link;

  @override
  void initState() {
     link = 'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=${widget.page}';
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<MovieBloc>().add(LoadApiResponseWithPage('https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=${widget.page}'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
      if (state is MovieLoading) {
        return const Loader();
      } else if (state is MovieError) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is ApiLoaded) {
        return RefreshIndicator(
          onRefresh: _refresh,
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 2,
                    childAspectRatio: 4/6,
                  ),
                  itemCount: state.listApi.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(2),
                        child: InkWell(
                            onTap: () {
                              final bloc = context.read<MovieBloc>();
                              final pathImage = state.listApi[index].posterUrl;
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
                              posterUrl: state.listApi[index].posterUrl,
                              height: 220,
                              width: 150,
                            )));
                  },
                ),
              ),
            ],
          ),
        );
      }
      return Container();
    });
  }
}
