import 'package:animevn/feature/home/presentation/view/home_movie_content_view.dart';
import 'package:animevn/feature/user/presentation/view/user_view.dart';
import 'package:animevn/shared/view/all_page_movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTab {
  static List<Tab> getHomeScreenTabs(int index) {
    return [
      Tab(
        icon: _buildItem(
          child: Icon(
            index == 0 ? Icons.home : Icons.home_outlined,
            color: Colors.blue,
          ),
          isChoose: index == 0,
          title: 'Home',
        ),
      ),
      Tab(
        icon: _buildItem(
          child: Icon(
            index == 1
                ? Icons.local_fire_department
                : Icons.local_fire_department_outlined,
            color: Colors.blue,
          ),
          isChoose: index == 1,
          title: 'All',
        ),
      ),
      Tab(
          icon: _buildItem(
        child: Container(
            decoration: BoxDecoration(
                color: index == 2 ? Colors.blue.shade500 : Colors.blue.shade100,
                // borderRadius: BorderRadius.circular(100),
                shape: BoxShape.circle),
            child: Hero(
                tag: 'splash',
                child: SvgPicture.asset('assets/logo.svg'))),
        isChoose: index == 2,
        title: 'Bonah',
      )),
    ];
  }

  static Widget _buildItem(
      {required Widget child, required bool isChoose, required String title}) {
    return Container(
      padding: EdgeInsets.only(top: !isChoose ? 5 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Expanded(child: child), !isChoose ? Text(title) : const SizedBox.shrink()],
      ),
    );
  }

  static List<Widget> tabViews() {
    return [
      const HomeMovieContentView(),
      const AllPageMoviesView(),
      const UserView()
    ];
  }

  AppTab._();
}
