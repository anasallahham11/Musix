import 'package:musix/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:musix/core/utils/values_manager.dart';

class CustomSongImageItemLoadingIndicator extends StatelessWidget {
  const CustomSongImageItemLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s16),
        child: Container(color: ColorManager.lightGrey,),
      ),
    );
  }
}
