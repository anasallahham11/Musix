
part of 'all_songs_cubit.dart';

abstract class AllSongsStates{}

class AllSongsInitialState extends AllSongsStates{}

class AllSongsLoadingState extends AllSongsStates{}

class AllSongsSuccessState extends AllSongsStates{
  final List<SongEntity> songs;

  AllSongsSuccessState(this.songs);
}

class AllSongsFailureState extends AllSongsStates{
  final String errorMessage;

  AllSongsFailureState(this.errorMessage);
}