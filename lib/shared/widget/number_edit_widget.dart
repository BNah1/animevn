import 'package:animevn/shared/widget/icon_text_button.dart';
import 'package:flutter/material.dart';
import '../../core/constant/const.dart';

class NumberEditWidget extends StatefulWidget {
  final int initialValue;
  final Function(int) onSubmit;

  const NumberEditWidget(
      {super.key, required this.initialValue, required this.onSubmit});

  @override
  State<NumberEditWidget> createState() => _NumberEditWidgetState();
}

class _NumberEditWidgetState extends State<NumberEditWidget> {
  late final TextEditingController controller;
  String errorMessage = '';

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue.toString());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _checkInput(String input) {
    // Check
    if (int.tryParse(input) == null) {
      setState(() {
        errorMessage = 'Please enter a valid number!';
      });
      return;
    }

    final number = int.parse(input);
    // Check range
    if ( number > 1878) {
      setState(() {
        errorMessage = 'Quantity cannot exceed 1878!';
      });
      return;
    } else if (number == 0){
      setState(() {
        errorMessage = 'Quantity cannot be zero!';
      });
      return;
    } else if (number < 0 )
    {
      setState(() {
        errorMessage = 'Quantity cannot lower than zero!';
      });
      return;
    }

    // clear message
    setState(() {
      errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Number Input', style: styleTile),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: errorMessage == '' ? Colors.black : Colors.red,
                // Màu viền
                width: 2, // Độ dày viền
              ),
            ),
            height: 50,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Write your number',
                  border: InputBorder.none,
                ),
                onChanged: _checkInput,
              ),
            ),
          ),
          // Display error
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const Spacer(),
          SizedBox(
              height: 50,
              width: 300,
              child: IconTextButton(
                  onPressed: () {
                    final input = controller.text.trim();
                    // xu ly neu chua nhap
                    if (input.isEmpty) {
                      setState(() {
                        errorMessage = 'Please put your number';
                      });
                    }
                    if (int.tryParse(input) != null) {
                      final number = int.parse(input);
                      if (number >= 1 && number <= 1878) {
                        widget.onSubmit(number);
                        // print('Test so: $number');
                        Navigator.pop(context);
                        setState(() {
                          errorMessage = '';
                        });
                      }
                    }
                  },
                  icon: Icons.move_down_rounded,
                  text: 'Ok')),
        ],
      ),
    );
  }
}
