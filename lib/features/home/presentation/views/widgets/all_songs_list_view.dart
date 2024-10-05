import 'package:flutter/material.dart';
import 'package:musix/core/utils/values_manager.dart';

import '../../../domain/entities/song_entity.dart';
import 'song_list_view_item.dart';

class AllSongsListView extends StatelessWidget {
  const AllSongsListView({Key? key, required this.songs}) : super(key: key);

  final List<SongEntity> songs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
          child: SongListViewItem(
            song: songs[index],
            songIndex: index,
            currentPlaylist: songs,
          ),
        );
      },
    );
  }
}
