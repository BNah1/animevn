import 'package:animevn/bloc/movie/movie_bloc.dart';
import 'package:animevn/bloc/movie/movie_event.dart';
import 'package:animevn/bloc/movie/movie_state.dart';
import 'package:animevn/constant/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/number_edit_widget.dart';
import 'movie/widget/list_movie_gridview.dart';

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
        body: Column(
          children: [
            Text('Phim mới cập nhập', style: styleTile,),
            SizedBox(height: 5),
            Expanded(
              child: ListMovieGridView(page: currentPage),
            ),
            SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicators(displayPages),
              ),
              _inputPage(),
            ]),
            SizedBox(height: 10),
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
        child: Text('...', style: styleTileIcon,),
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
          context.read<MovieBloc>().add(UploadCurrentPage(currentPage));
        },
      );
    });
  }

  List<Widget> _buildPageIndicators(List<int> displayPages) {
    return displayPages.map((page) {
      return BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
        return GestureDetector(
          onTap: () {
            setState(() {
              currentPage = page;
            });
            context.read<MovieBloc>()..add(UploadCurrentPage(page));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              '$page',
              style: TextStyle(
                fontSize: currentPage == page ? 20 : 16,
                fontWeight: FontWeight.bold,
                color: currentPage == page ? Colors.blue : Colors.black,
              ),
            ),
          ),
        );
      });
    }).toList();
  }
}
