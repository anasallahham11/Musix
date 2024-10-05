
part of 'search_cubit.dart';

abstract class SearchStates{}

class SearchInitialState extends SearchStates{}

class SearchLoadingState extends SearchStates{}

class SearchSuccessState extends SearchStates{
  final List<SongEntity> songs;

  SearchSuccessState(this.songs);
}

class SearchResultsUpdatedState extends SearchStates{
  final List<SongEntity> songs;

  SearchResultsUpdatedState(this.songs);
}

class SearchFailureState extends SearchStates{
  final String errorMessage;

  SearchFailureState(this.errorMessage);
}