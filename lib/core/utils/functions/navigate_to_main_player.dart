import 'package:flutter/material.dart';

import '../../../features/home/presentation/views/song_player_view.dart';
import '../values_manager.dart';

void navigateToMainPlayer(BuildContext context, {playlist, currentIndex}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: DurationConstant.kTransitionDuration400ms,
      pageBuilder: (context, animation, secondaryAnimation) =>
          SongPlayerView(playlist: playlist, currentIndex: currentIndex),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}