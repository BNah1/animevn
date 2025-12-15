import 'package:animate_do/animate_do.dart';
import 'package:animevn/core/bloc/movie/movie_bloc.dart';
import 'package:animevn/core/bloc/movie/movie_state.dart';
import 'package:animevn/core/constant/const.dart';
import 'package:animevn/shared/widget/movie_tile_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/movie/movie_event.dart';
import '../../../../shared/widget/loading.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.onTap});

  static const routeName = '/search';

  final Function onTap;
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
        builder: (blocContext, state) {
          return FadeInRight(
            // duration: const Duration(milliseconds: 500), // Thời gian animation
            child: Scaffold(
              backgroundColor: Colors.grey,
              appBar: AppBar(
                leading: GestureDetector(
                    onTap: (){
                      widget.onTap();
                    },
                    child: Icon(Icons.arrow_back_ios)),
                title: Card(
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Nhập từ khóa ...',
                    ),
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        isSearched = true;
                        BlocProvider.of<MovieBloc>(blocContext)
                            .add(SearchMovies(val));
                      } else {
                        isSearched = false;
                        BlocProvider.of<MovieBloc>(blocContext)
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
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: isSearched == false ? const Text('Top tim kiem: ',style: styleTile,) : SizedBox.shrink()),
                Expanded(child: _buildBody(state))] ),
            ),
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
