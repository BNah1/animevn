import 'package:flutter/material.dart';

class CustomSliderCard extends StatefulWidget {
  const CustomSliderCard({super.key, required this.listWidgets, this.listWidgetInfo, this.height = 200});

  final List<Widget> listWidgets;
  final List<Widget>? listWidgetInfo;
  final double height;

  @override
  State<CustomSliderCard> createState() => _CustomSliderCardState();
}

class _CustomSliderCardState extends State<CustomSliderCard> {
  final PageController _controller = PageController(viewportFraction: 0.75, initialPage: 1);
  double _page = 1;


  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _page = _controller.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: PageView.builder(
                    controller: _controller,
                    clipBehavior: Clip.none,
                    itemCount: widget.listWidgets.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final distance = index - _page;
                      final clamped = distance.clamp(-1.0, 1.0);

                      const scaleFactor = 0.85;
                      const yOffset = 50;
                      final scale =
                      (1 - clamped.abs() * (1 - scaleFactor)).clamp(0.8, 1.0);
                      final translateY = clamped.abs() * yOffset;

                      // 👇 tăng độ xoay trục
                      final double angleY = clamped * 0.7; // nghiêng trái-phải
                      final double angleX = -clamped.abs() * 0.35; // nghiêng trên-dưới

                      // 👇 tăng độ sâu perspective
                      final Matrix4 transform = Matrix4.identity()
                        ..setEntry(3, 2, 0.0008) // perspective mạnh hơn
                        ..rotateY(angleY)
                        ..rotateX(angleX);

                      return Transform(
                        alignment: Alignment.center,
                        transform: transform,
                        child: Transform.translate(
                          offset: Offset(0, translateY),
                          child: Transform.scale(
                            scale: scale,
                            child: widget.listWidgets[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.listWidgets.length, (index) {
              final isActive = (index - _page).abs() < 0.5;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 8,
                width: isActive ? 24 : 8,
                decoration: BoxDecoration(
                  color: isActive ? Colors.orange : Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),

          SizedBox(height: 10,),
          if(widget.listWidgetInfo!=null)widget.listWidgetInfo![_page.round()],

        ],
      ),
    );
  }
}
