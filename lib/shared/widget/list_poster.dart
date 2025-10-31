import 'package:animevn/core/bloc/movie/movie_bloc.dart';
import 'package:animevn/core/bloc/movie/movie_event.dart';
import 'package:animevn/core/bloc/movie/movie_state.dart';
import 'package:animevn/feature/home/presentation/widget/detail_poster_widget.dart';
import 'package:animevn/feature/home/presentation/widget/poster_widget.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:animevn/shared/widget/custom_slider_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading.dart';

const String _link = 'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=7';

class ListPoster extends StatefulWidget {
  const ListPoster({super.key});

  @override
  _ListPosterState createState() => _ListPosterState();
}

class _ListPosterState extends State<ListPoster> {

  @override
  void dispose() {
    print('ListPoster dispose');
    print('Listposter đã bị dispose : ${context.mounted}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc()..add( LoadApiResponseWithPage(_link)),
      child: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
        if (state is MovieLoading) {
          return const Loader();
        } else if (state is MovieError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is ApiLoaded) {
          return buildListPoster(state.listApi);
        }
        return Container();
      }),
    );
  }

  Widget buildListPoster(List<ApiResponse> list) {
    List<Widget> listWidgets = [];
    listWidgets =
        list.map((poster) => PosterWidget(api: poster,)).toList();
    List<Widget> listWidgetInfo = [];
    listWidgetInfo =
        list.map((poster) => DetailPosterWidget(api: poster,)).toList();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
          height: 550,
          width: double.infinity,
          child: CustomSliderCard(listWidgets: listWidgets, height: 500, listWidgetInfo: listWidgetInfo,)),
    );
  }
}
