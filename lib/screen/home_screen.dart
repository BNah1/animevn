import 'package:animevn/screen/search_screen.dart';
import 'package:animevn/screen/all_page_movies_screen.dart';
import 'package:animevn/widget/list_poster.dart';
import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import '../constant/constant.dart';
import 'movie/widget/list_movie_gridview_json.dart';
import 'movie/widget/list_movie_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          title: _buildFacebookText(),
          actions: [
            _buildSearchWidget(),
          ],
          bottom: TabBar(
            tabs: Constants.getHomeScreenTabs(_tabController.index),
            controller: _tabController,
            onTap: (index) {
              setState(() {});
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            RefreshIndicator(onRefresh: _refresh, child: _contentMovie()),
            AllPageMoviesScreen(),
            const ListMovieGridViewJson(
              title: 'Phim yêu thích',
              isFavourite: true,
            ),
            const ListMovieGridViewJson(
              title: 'Đang theo dõi ',
              isFavourite: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacebookText() => const Text(
        'Anime VN',
        style: TextStyle(
          color: AppColors.blueColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _buildSearchWidget() => InkWell(
        onTap: () {
          Navigator.pushNamed(context, SearchScreen.routeName);
        },
        child: const Icon(
          Icons.search,
          size: 30,
        ),
      );

  Widget _contentMovie() => SingleChildScrollView(
        key: UniqueKey(),
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
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
        ]),
      );
}
