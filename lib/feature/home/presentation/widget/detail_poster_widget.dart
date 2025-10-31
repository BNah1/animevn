import 'package:animevn/core/bloc/movie/movie_bloc.dart';
import 'package:animevn/core/constant/app_color.dart';
import 'package:animevn/core/constant/const.dart';
import 'package:animevn/feature/movie/presentation/view/movie_screen.dart';
import 'package:animevn/model/apirespone.dart';
import 'package:animevn/shared/utils/string_utils.dart';
import 'package:animevn/shared/widget/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPosterWidget extends StatelessWidget {
  const DetailPosterWidget({super.key, required this.api});

  final ApiResponse api;

  final double padding = 10;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          api.name,
          style: getText(),
        ),

        buildWatchButton(context),

        buildInfoNumber()
      ],
    );
  }

  Widget buildInfoNumber() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildItem(
              name: 'IDMb ${formatVote(api.voteAverage!)}',
              gradient: AppColors.buttonGradientColor,
              haveBackground: true,
              color: Colors.white),
          _buildItem(name: 'Vote: ${formatVote(api.voteCount!)}', color: Colors.white),
          _buildItem(name: api.year, color: Colors.yellow),
        ],
      ),
    );
  }

  Widget buildWatchButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding/2),
      child: IconTextButton(
        padding: 100,
        icon: Icons.play_arrow_rounded,
        text: 'Xem phim',
        onPressed: () {
          final bloc = context.read<MovieBloc>();
          final pathImage = api.posterUrl;
          Navigator.pushNamed(
            context,
            MovieScreen.routerName,
            arguments: {
              'slug': api.slug,
              'bloc': bloc,
              'pathImage': pathImage,
            },
          );
        },
      ),
    );
  }

  Widget _buildItem(
      {required String name,
      required Color color,
      bool haveBackground = false,
      String? title,
      Gradient? gradient}) {
    final backgroundColor = haveBackground ? color : Colors.transparent;
    return Padding(
      padding: const EdgeInsets.only(
          right: paddingSimple / 1.5, bottom: paddingSimple / 2),
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: paddingSimple / 2.5, horizontal: paddingSimple),
        decoration: BoxDecoration(
          gradient: gradient,
          color: gradient == null ? null : backgroundColor,
          border: haveBackground ? null : Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            title != null
                ? Text(
                    title,
                    style: TextStyle(color: color),
                  )
                : const SizedBox.shrink(),
            Text(
              name,
              style: TextStyle(color: gradient != null ? Colors.black : color),
            ),
          ],
        ),
      ),
    );
  }
}
