import 'package:animevn/feature/search/presentation/view/search_screen.dart';
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
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: _buildFacebookText(),
          actions: [
            _buildSearchWidget(),
          ],
        ),
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Tắt vuốt tay nếu chỉ muốn bấm tab
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

  Widget _buildFacebookText() => const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Anime VN',
            style: TextStyle(
              color: AppColors.blueColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  Widget _buildSearchWidget() => InkWell(
        onTap: () {
          setState(() {
            isSearching = true;
          });
          // Navigator.pushNamed(context, SearchScreen.routeName);
        },
        child: const Icon(
          Icons.search,
          size: 30,
        ),
      );
}
