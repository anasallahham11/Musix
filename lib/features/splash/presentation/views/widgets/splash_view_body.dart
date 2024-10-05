import 'package:musix/core/utils/assets_manager.dart';
import 'package:musix/core/utils/routes_manager.dart';
import 'package:musix/core/utils/values_manager.dart';
import 'package:musix/features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}
class _SplashViewBodyState extends State<SplashViewBody> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(AssetsManager.logo),
        const SizedBox(height: 4,),
        SlidingText(slidingAnimation: slidingAnimation)
      ],
    );
  }

  void initSlidingAnimation() {
    animationController=AnimationController(vsync: this,duration: DurationConstant.kTransitionDuration1s);
    slidingAnimation=Tween<Offset>(begin: const Offset(0, 2),end: Offset.zero).animate(animationController);
    animationController.forward();
  }
  void navigateToHome() {
    Future.delayed(
            DurationConstant.kTransitionDuration2s,
            (){GoRouter.of(context).pushReplacement(RoutesManager.homeRoute);}
    );
  }
}


