import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/features/home/presentation/views/widgets/search_result_list_view.dart';

import '../../../../../core/utils/strings_manager.dart';
import '../../manager/search_cubit/search_cubit.dart';

class SearchResultListViewBlocBuilder extends StatelessWidget {
  const SearchResultListViewBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchStates>(builder: (context, state) {
      if (state is SearchResultsUpdatedState) {
        if (state.songs.isEmpty) {
          return const Center(child: Text(StringsManager.noResults));
        }
        return SearchResultListView(
          songs: state.songs,
        );
      } else if (state is SearchFailureState) {
        return Center(child: Text(state.errorMessage));
      } else {
        return const Center(child: Text(StringsManager.searchMessage));
      }
    });
  }
}