import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musix/core/utils/values_manager.dart';
import 'package:musix/core/widgets/custom_fading_widget.dart';
import 'package:musix/features/home/domain/entities/song_entity.dart';
import '../../../../../core/utils/color_manager.dart';
import 'custom_mini_player_image_loading_indicator.dart';
import 'custom_mini_player_song_info_loading_indicator.dart';

class MiniPlayerLoadingIndicator extends StatelessWidget {
  const MiniPlayerLoadingIndicator({Key? key, this.song}) : super(key: key);
  final SongEntity? song;

  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget(
      childWidget: Container(
        height: AppSize.s50.h,
        margin:  EdgeInsets.all(AppMargin.m5.r),
        padding:  EdgeInsets.symmetric(horizontal: AppPadding.p10.r),
        decoration: BoxDecoration(
          color: ColorManager.darkGrey,
          borderRadius: BorderRadius.circular(AppSize.s24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomMiniPlayerImageLoadingIndicator(),
            const CustomMiniPlayerSongInfoLoadingIndicator(),
            IconButton(
              icon: Icon(Icons.skip_previous_rounded, color: ColorManager.white),
              onPressed: () {},
            ),
            CircularProgressIndicator(
              color: ColorManager.lightGrey,
            ),
            IconButton(
              icon: Icon(Icons.skip_next_rounded, color: ColorManager.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
