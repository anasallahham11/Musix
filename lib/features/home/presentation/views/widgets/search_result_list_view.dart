import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/core/utils/strings_manager.dart';
import 'package:musix/core/utils/values_manager.dart';
import '../../../domain/entities/song_entity.dart';
import '../../manager/search_cubit/search_cubit.dart';
import 'song_list_view_item.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({Key? key, required this.songs}) : super(key: key);

  final List<SongEntity> songs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p8, vertical: AppPadding.p10),
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


