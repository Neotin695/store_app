import 'package:flutter/material.dart';
import 'package:store_app/core/theme/colors/landk_colors.dart';
import 'package:store_app/core/theme/fonts/landk_fonts.dart';

// ignore: must_be_immutable
class CounterWidget extends StatefulWidget {
  const CounterWidget({
    super.key,
    required this.onIncrease,
    required this.onDecrease,
    required this.counter,
  });

  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final int counter;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: widget.onIncrease,
          icon: const Icon(Icons.add),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
              child: Text(
                widget.counter.toString(),
                style: h4,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: widget.onDecrease,
          icon: const Icon(Icons.remove),
        ),
      ],
    );
  }
}
