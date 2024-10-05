import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';

class CustomMiniPlayerSongInfoLoadingIndicator extends StatelessWidget {
  const CustomMiniPlayerSongInfoLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: AppSize.s10.h,
          width: AppSize.s100.w,
          color: ColorManager.lightGrey,
        ),
        const SizedBox(height: AppSize.s4),
        Container(
          height: AppSize.s10.h,
          width: AppSize.s100.w,
          color: ColorManager.lightGrey,
        ),
      ],
    );
  }
}