part of'song_player_cubit.dart';
abstract class SongPlayerStates{}

class SongPlayerInit extends SongPlayerStates{}

class SongPlayerLoading extends SongPlayerStates{}

class SongPlayerPlaylistLoaded extends SongPlayerStates{
  final List<SongEntity> playlist;
  final int currentIndex;

  SongPlayerPlaylistLoaded(this.playlist, this.currentIndex);
}

class SongPlayerUpdated extends SongPlayerStates{}

class SongPlayerBuffering extends SongPlayerStates{}

class SongPlayerPlaying extends SongPlayerStates{}

class SongPlayerPaused extends SongPlayerStates{}

class SongPlayerNext extends SongPlayerStates{}

class SongPlayerPrevious extends SongPlayerStates{}

class SongPlayerSeek extends SongPlayerStates{}

class SongPlayerFailure extends SongPlayerStates{}

