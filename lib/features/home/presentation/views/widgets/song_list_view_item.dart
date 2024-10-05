import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/core/utils/values_manager.dart';
import 'package:musix/features/home/domain/entities/song_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musix/features/home/presentation/manager/song_player_cubit/song_player_cubit.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';

class SongListViewItem extends StatelessWidget {
  const SongListViewItem(
      {Key? key,
      required this.song,
      required this.songIndex,
      required this.currentPlaylist})
      : super(key: key);

  final List<SongEntity> currentPlaylist;
  final SongEntity song;
  final int songIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SongPlayerCubit, SongPlayerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              context.read<SongPlayerCubit>().playPlaylist(
                  currentIndex: songIndex, playlist: currentPlaylist);
            },
            child: SizedBox(
              height: AppSize.s60,
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      child: CachedNetworkImage(
                        imageUrl: song.image ?? "",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: AppSize.s20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            song.title,
                            style: getSemiBoldStyle(color: ColorManager.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s4,
                        ),
                        Text(
                          song.artist ?? "Undefined",
                          style: getMediumStyle(color: ColorManager.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
