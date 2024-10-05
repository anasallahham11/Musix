
part of 'featured_songs_cubit.dart';


abstract class FeaturedSongsStates{}

class FeaturedSongsInitialState extends FeaturedSongsStates{}

class FeaturedSongsLoadingState extends FeaturedSongsStates{}

class FeaturedSongsPaginationLoadingState extends FeaturedSongsStates{}

class FeaturedSongsSuccessState extends FeaturedSongsStates{
  final List<SongEntity> songs;

  FeaturedSongsSuccessState(this.songs);
}

class FeaturedSongsFailureState extends FeaturedSongsStates{
  final String errorMessage;

  FeaturedSongsFailureState(this.errorMessage);
}

class FeaturedSongsPaginationFailureState extends FeaturedSongsStates{
  final String errorMessage;

  FeaturedSongsPaginationFailureState(this.errorMessage);
}