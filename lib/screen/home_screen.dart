import 'package:animevn/screen/movie/widget/list_movie_gridview.dart';
import 'package:animevn/widget/list_poster.dart';
import 'package:animevn/widget/network_video_view.dart';
import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import '../constant/constant.dart';
import '../utils/utils.dart';
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
                  ListMovieRow(inputdata: getMovie(), title: 'Phim moi cap nhap',),
                  ListMovieRow(inputdata: getMovie(),title: 'Phim dang theo doi'),
                  ListMovieRow(inputdata: getMovie(),title: 'Phim top rating'),
                  ListMovieRow(inputdata: getMovie(),title: 'Phim Vip'),
                ])),
            ListMovieGridView(inputdata: getMovie()),
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
        onTap: () {},
        child: Icon(
          Icons.search,
        ),
      );

  Widget _buildMessengerWidget() =>
      InkWell(onTap: () {}, child: Icon(Icons.invert_colors_on_sharp));
}
