import 'package:musix/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/song_entity.dart';
import '../../manager/featured_songs_cubit/featured_songs_cubit.dart';
import 'featured_songs_list_view.dart';
import 'featured_songs_list_view_loading_indicator.dart';

class FeaturedSongsListViewBlocConsumer extends StatefulWidget {
  const FeaturedSongsListViewBlocConsumer({
    super.key,
  });

  @override
  State<FeaturedSongsListViewBlocConsumer> createState() =>
      _FeaturedSongsListViewBlocConsumerState();
}

class _FeaturedSongsListViewBlocConsumerState
    extends State<FeaturedSongsListViewBlocConsumer> {
  List<SongEntity> songs = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedSongsCubit, FeaturedSongsStates>(
        listener: (context, state) {
      if (state is FeaturedSongsSuccessState) {
        songs.addAll(state.songs);
      }
      if (state is FeaturedSongsPaginationFailureState) {
        showToast(text: state.errorMessage, state: ToastStates.error);
      }
    },
        builder: (context, state) {
      if (state is FeaturedSongsSuccessState ||
          state is FeaturedSongsPaginationLoadingState ||
          state is FeaturedSongsPaginationFailureState) {
        return FeaturedSongsListView(
          songs: songs,
        );
      } else if (state is FeaturedSongsFailureState) {
        return Center(child: Text(state.errorMessage));
      } else {
        return const FeaturedSongsListViewLoadingIndicator();
      }
    });
  }
}
