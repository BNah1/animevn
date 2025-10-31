import 'package:animevn/core/bloc/movie/movie_bloc.dart';
import 'package:animevn/core/bloc/movie/movie_event.dart';
import 'package:animevn/core/bloc/movie/movie_state.dart';
import 'package:animevn/core/constant/app_color.dart';
import 'package:animevn/core/constant/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/number_edit_widget.dart';
import '../../feature/home/presentation/widget/list_movie_gridview.dart';

class AllPageMoviesScreen extends StatefulWidget {
  @override
  _AllPageMoviesScreenState createState() => _AllPageMoviesScreenState();
}

class _AllPageMoviesScreenState extends State<AllPageMoviesScreen> {
  final int totalPages = 1878;
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    List<int> displayPages = _getDisplayPages();

    return BlocProvider(
      create: (context) => MovieBloc()..add(UploadCurrentPage(currentPage)),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            const Text('Phim mới cập nhập', style: styleTile,),
            const SizedBox(height: 5),
            Expanded(
              child: ListMovieGridView(page: currentPage),
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicators(displayPages),
              ),
              _inputPage(),
            ]),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  List<int> _getDisplayPages() {
    // Tính toán trang bắt đầu và kết thúc để hiển thị
    int startPage = (currentPage > 4) ? currentPage - 3 : 1;
    int endPage = (startPage + 4 <= totalPages) ? startPage + 4 : totalPages;

    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  Widget _inputPage() {
    return BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
      return InkWell(
        child: const Text('...', style: styleTileIcon,),
        onTap: () async {
        await  showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: NumberEditWidget(
                  initialValue: currentPage,
                  onSubmit: (newPage) {
                    setState(() {
                      currentPage = newPage;
                    });
                  },
                ),
              );
            },
          );
          if(context.mounted) context.read<MovieBloc>().add(UploadCurrentPage(currentPage));
        },
      );
    });
  }

  List<Widget> _buildPageIndicators(List<int> displayPages) {
    return displayPages.map((page) {
      return BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
        final isCurrentPage = currentPage == page;
        return GestureDetector(
          onTap: () {
            setState(() {
              currentPage = page;
            });
            context.read<MovieBloc>().add(UploadCurrentPage(page));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              '$page',
              style: TextStyle(
                fontSize: isCurrentPage ? 20 : 16,
                fontWeight: isCurrentPage ? FontWeight.bold : FontWeight.w500,
                color: isCurrentPage ? Colors.white : Colors.grey,
              ),
            ),
          ),
        );
      });
    }).toList();
  }
}
