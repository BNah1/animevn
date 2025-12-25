import 'package:animevn/shared/widget/custom_bottom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:animevn/core/constant/app_color.dart';
import 'package:animevn/core/constant/app_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppTab.tabViews().length,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: AppTab.tabViews(),
            ),
            CustomBottomTabBar(
                selectedIndex: _selectedIndex,
                onItemTapped: _onItemTapped,
                onCenterTap: (){
                  _onItemTapped(2);
                })
          ],
        ),
      )
    );
  }

}
