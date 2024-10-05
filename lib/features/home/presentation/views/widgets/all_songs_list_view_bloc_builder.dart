import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/all_songs_cubit/all_songs_cubit.dart';
import 'all_songs_list_view.dart';

class AllSongsListViewBlocBuilder extends StatelessWidget {
  const AllSongsListViewBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllSongsCubit, AllSongsStates>(
        builder: (context, state) {
      if (state is AllSongsSuccessState) {
        return AllSongsListView(
          songs: state.songs,
        );
      } else if (state is AllSongsFailureState) {
        return Center(child: Text(state.errorMessage));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
