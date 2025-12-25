import 'package:animevn/feature/home/presentation/widget/list_movie_row.dart';
import 'package:animevn/shared/widget/custom_app_bar_widget.dart';
import 'package:animevn/shared/widget/list_poster.dart';
import 'package:flutter/material.dart';

class HomeMovieContentView extends StatefulWidget {
  const HomeMovieContentView({super.key});

  @override
  State<HomeMovieContentView> createState() => _HomeMovieContentViewState();
}

class _HomeMovieContentViewState extends State<HomeMovieContentView> {
  @override
  Widget build(BuildContext context) {

    Future<void> _refresh() async {
      setState(() {});
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: const CustomAppBarWidget(),
        body: SingleChildScrollView(
          key: UniqueKey(),
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: const Column(children: [
            ListPoster(),
            ListMovieRow(
              title: 'Anime',
              link: 'https://phimapi.com/v1/api/danh-sach/hoat-hinh',
              isPage: false,
            ),
            ListMovieRow(
              title: 'TV-Show',
              link: 'https://phimapi.com/v1/api/danh-sach/tv-shows',
              isPage: false,
            ),
            ListMovieRow(
              title: 'Phim mới cập nhập',
              link: 'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=2',
              isPage: true,
            ),
            ListMovieRow(
              title: 'Phim lẻ',
              link: 'https://phimapi.com/v1/api/the-loai/hanh-dong',
              isPage: false,
            ),
            ListMovieRow(
              title: 'Phim bộ',
              link: 'https://phimapi.com/v1/api/danh-sach/phim-bo',
              isPage: false,
            ),

            SizedBox(
              height: 80,)
          ]),
        ),
      ),
    );
  }
}
