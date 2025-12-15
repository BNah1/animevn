import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const Color _colorIconFAB = Colors.white;
const Color _backgroundColorFAB = Color(0xFFF06292); // Pink 300
const Color _backgroundColorTab = Colors.white;
const Color _active = Color(0xFFF8BBD0); // Pink 100
const Color _unActive = Colors.grey;

class CustomBottomTabBar extends StatelessWidget {
  const CustomBottomTabBar(
      {super.key,
      this.heightTab = 50,
      this.colorIconFAB = _colorIconFAB,
      this.backgroundColorFAB = _backgroundColorFAB,
      this.backgroundColorTab = _backgroundColorTab,
      this.active = _active,
      this.unActive = _unActive, required this.selectedIndex, required this.onItemTapped, required this.onCenterTap});

  final double heightTab;
  final Color colorIconFAB;
  final Color backgroundColorFAB;
  final Color backgroundColorTab;
  final Color active;
  final Color unActive;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final VoidCallback onCenterTap; // Sự kiện cho nút giữa (FAB)

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double sizeFAB = 60;
    final colorFAB = selectedIndex == 2 ? backgroundColorFAB : unActive;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            color: Colors.transparent,
            width: size.width,
            height: heightTab,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, heightTab),
                  painter: BNBCustomPainter(background: _backgroundColorTab),
                ),
                Center(
                  heightFactor: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIcon(Icons.home, 0),
                      Container(width: size.width * 0.20),
                      _buildIcon(Icons.home, 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Nút FAB ở giữa
        Positioned(
          bottom: heightTab/5,
          child: InkWell(
            onTap: () => onCenterTap(),
            child: Container(
              width: sizeFAB,
              height: sizeFAB,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorFAB,
                  boxShadow: [
                    BoxShadow(
                        color: colorFAB.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5))
                  ]),
              child: Container(
                padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle),
                  child: Hero(
                      tag: 'splash',
                      child: SvgPicture.asset('assets/logo.svg'))),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    // Kiểm tra xem tab này có đang được chọn không
    bool isSelected = selectedIndex == index;

    return IconButton(
      icon: Icon(
          icon,
          color: isSelected ? active : unActive
      ),
      onPressed: () => onItemTapped(index),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  final Color background;

  BNBCustomPainter({super.repaint, required this.background});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = background
      ..style = PaintingStyle.fill;

    Path path = Path();

    // --- CẤU HÌNH KÍCH THƯỚC NOTCH ---
    double center = size.width / 2;
    double navHeight = 25; // Chiều cao của đoạn lún xuống
    double notchMargin =
        35.0; // Khoảng cách từ tâm ra đến mép đáy lún (Độ rộng đáy)
    double curveDistance =
        25.0; // Khoảng cách uốn lượn từ mép đáy lên đường thẳng

    // 1. Bắt đầu vẽ khung
    path.moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);

    // 2. Vẽ đường thẳng đến điểm bắt đầu uốn (Bên Trái)
    path.lineTo(center - notchMargin - curveDistance, 0);

    // 3. Đường cong đi xuống (Bên Trái)
    path.quadraticBezierTo(
        center - notchMargin,
        0, // Control Point (Góc vuông ảo)
        center - notchMargin + 10,
        navHeight // Điểm đến (Bắt đầu đáy arc)
        );

    // 4. Đáy vòng cung (Ở Giữa)
    path.arcToPoint(
      Offset(center + notchMargin - 10, navHeight), // Điểm đến bên phải
      radius: Radius.circular(50),
      clockwise: false,
    );

    // 5. Đường cong đi lên (Bên Phải)
    // Đối xứng hoàn toàn với bước 3
    path.quadraticBezierTo(
        center + notchMargin,
        0, // Control Point
        center + notchMargin + curveDistance,
        0 // Điểm kết thúc về lại đường thẳng
        );

    // 6. Vẽ tiếp đường thẳng bên phải
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);

    // 7. Đóng khung
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Vẽ bóng và khung
    canvas.drawShadow(path, Colors.black.withOpacity(0.1), 5.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
