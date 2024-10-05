
import 'package:musix/features/home/domain/usecases/fetch_featured_songs_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/song_entity.dart';

part 'featured_songs_states.dart';
class FeaturedSongsCubit extends Cubit<FeaturedSongsStates>{
  FeaturedSongsCubit(this.featuredSongsUseCase) : super(FeaturedSongsInitialState());
  final FetchFeaturedSongsUseCase featuredSongsUseCase;

  Future<void> fetchFeaturedSongs({int pageNumber=0}) async{
    if(pageNumber==0) {
      emit(FeaturedSongsLoadingState());
    }else{
      emit(FeaturedSongsPaginationLoadingState());
    }
    var result = await featuredSongsUseCase.call(pageNumber);
    result.fold(
            (failure) {
              if(pageNumber==0) {
                emit(FeaturedSongsFailureState(failure.message));
              }else{
                emit(FeaturedSongsPaginationFailureState(failure.message));
              }
            },
            (books) => emit(FeaturedSongsSuccessState(books))
    );
  }
}