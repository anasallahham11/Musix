import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/core/utils/font_manager.dart';
import 'package:musix/core/utils/functions/download_song.dart';
import 'package:musix/core/utils/strings_manager.dart';
import 'package:musix/core/utils/style_manager.dart';
import 'package:musix/core/utils/values_manager.dart';
import 'package:musix/core/widgets/custom_button.dart';
import 'package:musix/features/home/domain/entities/song_entity.dart';
import 'package:musix/features/home/presentation/manager/song_player_cubit/song_player_cubit.dart';
import 'package:musix/features/home/presentation/views/widgets/custom_song_image_item.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/functions/format_duration.dart';

class SongPlayerView extends StatelessWidget {
  List<SongEntity> playlist;
  int currentIndex;

  SongPlayerView({Key? key, required this.playlist, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SongPlayerCubit, SongPlayerStates>(
      listener: (context, state) {
        currentIndex = SongPlayerCubit.get(context).audioPlayer.currentIndex!;
        if (state is SongPlayerPlaylistLoaded) {
          playlist = state.playlist;
          currentIndex = state.currentIndex;
        }
      },
      builder: (context, state) {
        currentIndex = SongPlayerCubit.get(context).audioPlayer.currentIndex ??
            currentIndex;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              StringsManager.nowPlaying,
              style: getSemiBoldStyle(color: ColorManager.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p16, horizontal: AppPadding.p16),
            child: Column(
              children: [
                SongCover(playlist: playlist, currentIndex: currentIndex),
                const SizedBox(
                  height: AppSize.s30,
                ),
                SongDetails(playlist: playlist, currentIndex: currentIndex),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Column(
                  children: [
                    Slider(
                      value: context
                          .read<SongPlayerCubit>()
                          .songPosition
                          .inSeconds
                          .toDouble(),
                      min: 0.0,
                      max: context
                          .read<SongPlayerCubit>()
                          .songDuration
                          .inSeconds
                          .toDouble(),
                      activeColor: ColorManager.white,
                      inactiveColor: ColorManager.grey,
                      onChanged: (value) {
                        context
                            .read<SongPlayerCubit>()
                            .updateSliderPosition(value);
                      },
                      onChangeEnd: (value) {
                        context
                            .read<SongPlayerCubit>()
                            .seekToPosition(Duration(seconds: value.toInt()));
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatDuration(
                            context.read<SongPlayerCubit>().songPosition)),
                        Text(formatDuration(
                            context.read<SongPlayerCubit>().songDuration))
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          function: () {
                            context.read<SongPlayerCubit>().toggleLoopMode();
                          },
                          height: AppSize.s70,
                          width: AppSize.s70,
                          icon: Icons.repeat_rounded,
                          iconSize: AppSize.s32,
                          iconColor:
                              context.read<SongPlayerCubit>().loopCurrentSong
                                  ? ColorManager.white
                                  : ColorManager.grey,
                        ),
                        CustomButton(
                          function: () {
                            context.read<SongPlayerCubit>().seekPrevious();
                          },
                          height: AppSize.s70,
                          width: AppSize.s70,
                          icon: Icons.skip_previous_rounded,
                          iconSize: AppSize.s32,
                        ),
                        context.read<SongPlayerCubit>().isBuffering
                            ? CircularProgressIndicator(
                                color: ColorManager.grey,
                              )
                            : CustomButton(
                                function: () {
                                  context
                                      .read<SongPlayerCubit>()
                                      .playPauseSong();
                                },
                                height: AppSize.s70,
                                width: AppSize.s70,
                                icon: context
                                        .read<SongPlayerCubit>()
                                        .audioPlayer
                                        .playing
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                iconSize: AppSize.s50,
                                backgroundColor: ColorManager.primary,
                              ),
                        CustomButton(
                          function: () {
                            context.read<SongPlayerCubit>().seekNext();
                          },
                          height: AppSize.s70,
                          width: AppSize.s70,
                          icon: Icons.skip_next_rounded,
                          iconSize: AppSize.s32,
                        ),
                        CustomButton(
                          function: () {
                            context
                                .read<SongPlayerCubit>()
                                .shufflePlaylist();
                          },
                          height: AppSize.s70,
                          width: AppSize.s70,
                          icon: Icons.shuffle_rounded,
                          iconSize: AppSize.s32,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class SongDetails extends StatelessWidget {
  const SongDetails({
    super.key,
    required this.playlist,
    required this.currentIndex,
  });

  final List<SongEntity> playlist;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playlist[currentIndex].title,
              style: getBoldStyle(
                  color: ColorManager.white, fontSize: FontSize.s22),
            ),
            const SizedBox(
              height: AppSize.s5,
            ),
            Text(
              playlist[currentIndex].artist!,
              style: getBoldStyle(
                  color: ColorManager.grey2, fontSize: FontSize.s16),
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              saveFileToDownloads(playlist[currentIndex].streamingUrl!,
                  playlist[currentIndex].title, context);
            },
            icon: Icon(
              Icons.download_rounded,
              size: AppSize.s32,
              color: ColorManager.grey,
            )),
      ],
    );
  }
}

class SongCover extends StatelessWidget {
  const SongCover({
    super.key,
    required this.playlist,
    required this.currentIndex,
  });

  final List<SongEntity> playlist;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: CustomSongImageItem(image: playlist[currentIndex].image!),
    );
  }
}
