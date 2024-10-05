import 'package:flutter/material.dart';
import 'package:musix/core/utils/values_manager.dart';

class CustomFadingWidget extends StatefulWidget {
  const CustomFadingWidget({Key? key, required this.childWidget}) : super(key: key);
  final Widget childWidget;

  @override
  State<CustomFadingWidget> createState() => _CustomFadingWidgetState();
}

class _CustomFadingWidgetState extends State<CustomFadingWidget> with SingleTickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: DurationConstant.kTransitionDuration800ms);
    animation=Tween<double>(begin: 0.2,end: 0.8).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.stop();
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: animation.value,
        child: widget.childWidget,
    );
  }
}
