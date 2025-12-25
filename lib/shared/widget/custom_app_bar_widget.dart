import 'package:animevn/core/constant/app_color.dart';
import 'package:animevn/core/constant/route.dart';
import 'package:flutter/material.dart';


class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      title: _buildFacebookText(),
      actions: [
        _buildSearchWidget(context),
      ],
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

  Widget _buildSearchWidget(BuildContext context) => InkWell(
    onTap: () {
      print('pushNAME');
      Navigator.pushNamed(context, AppRoutes.search);
    },
    child: const Icon(
      Icons.search,
      size: 30,
    ),
  );
}
