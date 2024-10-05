import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musix/core/utils/assets_manager.dart';
import 'package:musix/core/utils/color_manager.dart';
import 'package:musix/core/utils/font_manager.dart';
import 'package:musix/core/utils/strings_manager.dart';
import 'package:musix/core/utils/style_manager.dart';
import 'package:musix/core/utils/values_manager.dart';
import 'package:musix/features/home/domain/entities/song_entity.dart';
import 'package:musix/features/home/presentation/manager/song_player_cubit/song_player_cubit.dart';
import '../../../../../core/utils/functions/navigate_to_main_player.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer(
      {Key? key, required this.playlist, required this.currentIndex})
      : super(key: key);
  final List<SongEntity> playlist;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SongPlayerCubit>();
    return Container(
      height: AppSize.s50.h,
      margin:  EdgeInsets.all(AppMargin.m8.r),
      padding:  EdgeInsets.symmetric(horizontal: AppPadding.p10.r),
      decoration: BoxDecoration(
        color: ColorManager.darkGrey,
        borderRadius: BorderRadius.circular(AppSize.s24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if(playlist.isNotEmpty) {
                navigateToMainPlayer(context,
                  playlist: playlist, currentIndex: currentIndex);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s32.r),
              child: playlist.isNotEmpty
                  ? Image.network(
                      playlist[currentIndex].image!,
                      width: AppSize.s50.w,
                      height: AppSize.s50.h,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AssetsManager.music,
                      width: AppSize.s50.w,
                      height: AppSize.s50.h,
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.isNotEmpty
                        ? playlist[currentIndex].title
                        : StringsManager.chooseSong,
                    style: getBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSize.s4),
                  Text(
                    playlist.isNotEmpty
                        ? playlist[currentIndex].artist ?? StringsManager.undefined
                        : StringsManager.undefined,
                    style: getMediumStyle(
                        color: ColorManager.grey, fontSize: FontSize.s14.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
            onPressed: () {
              cubit.seekPrevious();
            },
          ),
          cubit.isBuffering
              ? CircularProgressIndicator(
                  color: ColorManager.grey,
                )
              : IconButton(
                  icon: Icon(
                    cubit.audioPlayer.playing
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    cubit.playPauseSong();
                  },
                ),
          IconButton(
            icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
            onPressed: () {
              cubit.seekNext();
            },
          ),
        ],
      ),
    );
  }
}
