import 'package:animevn/screen/search_screen.dart';
import 'package:animevn/widget/list_poster.dart';
import 'package:animevn/screen/videoplayer/widget/network_video_view.dart';
import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import '../constant/constant.dart';
import 'movie/widget/list_movie_gridview.dart';
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
            _buildMessengerWidget(),
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
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  ListPoster(),
                  ListMovieRow(title: 'Anime', link: 'https://phimapi.com/v1/api/danh-sach/hoat-hinh', isPage: false,),
                  ListMovieRow(title: 'TV-Show', link: 'https://phimapi.com/v1/api/danh-sach/tv-shows', isPage: false,),
                  ListMovieRow(title: 'Phim mới cập nhập', link: 'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=2', isPage: true,),
                  ListMovieRow(title: 'Phim lẻ', link: 'https://phimapi.com/v1/api/danh-sach/phim-le', isPage: false,),
                  ListMovieRow(title: 'Phim bộ', link: 'https://phimapi.com/v1/api/danh-sach/phim-bo', isPage: false,),
                ])),
            ListMovieGridView(),
            Center(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                  height: 300,
                  width: 500,
                  child: NetworkVideoView(videoUrl: Constants.testVideoUrl)),
            )),
            Container(
              color: Colors.blue,
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
        child: Icon(
          Icons.search,
        ),
      );

  Widget _buildMessengerWidget() =>
      InkWell(onTap: () {}, child: Icon(Icons.invert_colors_on_sharp));
}
