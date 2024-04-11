import 'package:flutter/material.dart';

class AnimatedSymbol extends StatefulWidget {
  final bool selected;
  final IconData symbol;
  const AnimatedSymbol(
      {super.key, required this.selected, required this.symbol});

  @override
  State<AnimatedSymbol> createState() => _AnimatedSymbolState();
}

class _AnimatedSymbolState extends State<AnimatedSymbol> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: widget.selected ? 1 : 0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Icon(
          widget.symbol,
          weight: value * 100 + 600,
          fill: value,
          opticalSize: value * 20 + 28,
        );
      },
    );
  }
}
