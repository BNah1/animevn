import 'package:animevn/core/constant/const.dart';
import 'package:flutter/material.dart';

class ListActionButtonMovie extends StatefulWidget {
  const ListActionButtonMovie({super.key});

  @override
  State<ListActionButtonMovie> createState() => _ListActionButtonMovieState();
}

class _ListActionButtonMovieState extends State<ListActionButtonMovie> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: _listButton(context).map((e) => Expanded(child: buildButton(e))).toList()
    );
  }


  Widget buildButton(_Button button){
    return InkWell(
      onTap: button.onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(button.icon),
          Text(button.title, style: const TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}


List<_Button> _listButton(BuildContext context){
  return [
    _Button(icon: Icons.favorite, title: 'Yêu thich', onTap: (){}),
    _Button(icon: Icons.add, title: 'Thêm vào', onTap: (){}),
    _Button(icon: Icons.how_to_vote_rounded, title: ' Danh gia', onTap: (){}),
    _Button(icon: Icons.comment, title: 'Bình luận', onTap: (){}),
    _Button(icon: Icons.share_rounded, title: 'Chia sẻ', onTap: (){}),
  ];
}

class _Button{
  final IconData icon;
  final String title;
  final Function onTap;

  _Button({required this.icon, required this.title, required this.onTap});
}