import 'package:flutter/material.dart';
import 'package:musix/core/utils/strings_manager.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slidingAnimation,
        builder: (context,_) {
          return SlideTransition(
              position: slidingAnimation,
              child: const Text(StringsManager.splashText,textAlign: TextAlign.center,));
        }
    );
  }
}