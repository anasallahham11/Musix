
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/song_entity.dart';
import '../../../domain/usecases/fetch_all_songs_usecase.dart';


part 'all_songs_states.dart';
class AllSongsCubit extends Cubit<AllSongsStates>{
  AllSongsCubit(this.allSongsUseCase) : super(AllSongsInitialState());
  final FetchAllSongsUseCase allSongsUseCase;

  Future<void> fetchAllSongs() async{
    emit(AllSongsLoadingState());
    var result = await allSongsUseCase.call();
    result.fold(
            (failure) => emit(AllSongsFailureState(failure.message)),
            (songs) => emit(AllSongsSuccessState(songs))
    );
  }
}