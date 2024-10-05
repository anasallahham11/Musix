
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/song_entity.dart';
import '../../../domain/usecases/fetch_all_songs_usecase.dart';


part 'search_states.dart';
class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(this.allSongsUseCase) : super(SearchInitialState());
  final FetchAllSongsUseCase allSongsUseCase;

  List<SongEntity> allSongs=[];
  List<SongEntity> searchResult=[];

  Future<void> fetchAllSongs() async{
    emit(SearchLoadingState());
    var result = await allSongsUseCase.call();
    result.fold(
            (failure) => emit(SearchFailureState(failure.message)),
            (songs) {
              allSongs=songs;
              emit(SearchSuccessState(songs));
            }
    );
  }

  void searchSongs(String query) {
    if (query.isEmpty) {
      searchResult = [];
    } else {
      searchResult = allSongs
          .where((song) =>
      song.title.toLowerCase().contains(query.toLowerCase()) ||
          song.artist?.toLowerCase().contains(query.toLowerCase()) == true)
          .toList();
    }
    emit(SearchResultsUpdatedState(searchResult));
  }
}