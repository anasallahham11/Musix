import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';

class CustomMiniPlayerImageLoadingIndicator extends StatelessWidget {
  const CustomMiniPlayerImageLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.s24),
      child: Container(
        height: AppSize.s50.h,
        width: AppSize.s50.w,
        color: ColorManager.lightGrey,
      ),
    );
  }
}
