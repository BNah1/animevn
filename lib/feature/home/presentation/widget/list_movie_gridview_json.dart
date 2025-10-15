import 'package:animevn/feature/favourite_movie/presentation/state/bloc/storage_bloc.dart';
import 'package:animevn/feature/favourite_movie/presentation/state/bloc/storage_event.dart';
import 'package:animevn/feature/favourite_movie/presentation/state/bloc/storage_state.dart';
import 'package:animevn/core/constant/const.dart';
import 'package:animevn/feature/movie/presentation/view/movie_screen.dart';
import 'package:animevn/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widget/movie_tile_homepage.dart';

class ListMovieGridViewJson extends StatefulWidget {
  const ListMovieGridViewJson({super.key, required this.title, required this.isFavourite});
final String title;
final bool isFavourite;
  @override
  State<ListMovieGridViewJson> createState() => _ListMovieGridViewJsonState();
}

class _ListMovieGridViewJsonState extends State<ListMovieGridViewJson> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageBloc, StorageState>(builder: (context, state) {
      final items = state.items.values
          .where((item) =>  widget.isFavourite ? item.favourite : item.seen)
          .toList();
      return Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(widget.title,style: styleTile,)),
          items.isEmpty ? Expanded(child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'assets/emptybox.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const Text('No data',style: styleTileIcon,)
          ],))) : Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 2,
                childAspectRatio: 3 / 4,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MovieScreen.routerName, arguments: item.api.slug);
                    },
                    child: Stack(
                      children: [
                        MovieTileHomepage(
                          name: item.api.name,
                          posterUrl: item.api.posterUrl,
                          height: 400,
                          widght: 300,
                        ),
                        widget.isFavourite ? const SizedBox.shrink() : Positioned(
                          top: 5,
                          right: 5,
                          child: InkWell(
                            onTap: () {
                              context.read<StorageBloc>().add(RemoveSeen(item.api.slug));
                              showToastMessage(text: 'Xoa thanh cong');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'X',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                );
                            },
            ),
          ),
        ],
      );
    });
  }
}
