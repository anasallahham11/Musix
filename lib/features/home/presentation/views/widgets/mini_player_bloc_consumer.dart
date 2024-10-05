import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/song_entity.dart';
import '../../manager/song_player_cubit/song_player_cubit.dart';
import 'mini_player.dart';
import 'mini_player_loading_indicator.dart';

class MiniPlayerBlocConsumer extends StatefulWidget {
  const MiniPlayerBlocConsumer({super.key});

  @override
  State<MiniPlayerBlocConsumer> createState() => _MiniPlayerBlocConsumerState();
}

class _MiniPlayerBlocConsumerState extends State<MiniPlayerBlocConsumer> {
  List<SongEntity> playlist = [];
  int currentIndex = 0;

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
        currentIndex = SongPlayerCubit.get(context).audioPlayer.currentIndex ?? currentIndex;
        playlist=SongPlayerCubit.get(context).currentPlaylist;
        if (state is SongPlayerLoading) {
          return const MiniPlayerLoadingIndicator();
        }
        return MiniPlayer(playlist: playlist, currentIndex: currentIndex);
      },
    );
  }
}
