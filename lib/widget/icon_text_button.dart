import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant/const.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
    this.color,
    this.padding,
  });

  final IconData icon;
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      // style: TextButton.styleFrom(
      //   backgroundColor: color ?? Colors.blue,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     side: const BorderSide(color: Colors.transparent),
      //   ),
      // ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding ?? 20),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFD54F), // vàng tươi nhẹ ở giữa
                Color(0xFFFFE082), // vàng pastel
                Color(0xFFFFF3C2), // vàng sáng kem ở góc trên
                Color(0xFFFFF8E9), // vàng nhạt mịn ở cuối
                Color(0xFFFFF3C2), // vàng sáng kem ở góc trên
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                color: Colors.white,
              ),
              // Biểu tượng
              const SizedBox(width: 8),
              // Khoảng cách giữa biểu tượng và văn bản
              Text(text, style: styleTextInButton),
            ],
          ),
        ),
      ),
    );
  }
}
