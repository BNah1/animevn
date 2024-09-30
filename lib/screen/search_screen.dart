import 'package:animevn/bloc/movie/movie_bloc.dart';
import 'package:animevn/bloc/movie/movie_state.dart';
import 'package:animevn/constant/const.dart';
import 'package:animevn/widget/movie_tile_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie/movie_event.dart';
import '../widget/loading.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearched = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc()..add(SearchMovies('anime')),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Card(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Nhập từ khóa ...',
                  ),
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      isSearched = true;
                      BlocProvider.of<MovieBloc>(context)
                          .add(SearchMovies(val));
                    } else {
                      isSearched = false;
                      BlocProvider.of<MovieBloc>(context)
                          .add(SearchMovies('anime'));
                    }
                  },
                ),
              ),
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: isSearched == false ? Text('Top tim kiem: ',style: styleTile,) : SizedBox.shrink()),
              Expanded(child: _buildBody(state))] ),
          );
        },
      ),
    );
  }

  Widget _buildBody(MovieState state) {
    if (state is MovieLoading) {
      return const Loader();
    } else if (state is MovieError) {
      return Center(
        child: Text(state.message),
      );
    } else if (state is ApiLoaded) {
      return ListView.builder(
        itemCount: state.listApi.length,
        itemBuilder: (context, index) {
          return MovieTileSearch(data: state.listApi[index]);
        },
      );
    }
    return Container();
  }
}
