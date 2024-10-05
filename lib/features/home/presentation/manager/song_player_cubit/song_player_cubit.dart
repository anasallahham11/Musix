import 'package:just_audio/just_audio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musix/features/home/domain/entities/song_entity.dart';

part 'song_player_states.dart';

class SongPlayerCubit extends Cubit<SongPlayerStates> {
  static SongPlayerCubit get(context) => BlocProvider.of(context);

  ///Variables
  AudioPlayer audioPlayer = AudioPlayer();
  List<AudioSource> audioSources = [];
  List<SongEntity> currentPlaylist = [];
  bool loopCurrentSong = false;
  bool isBuffering = false;
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  ///Constructor
  SongPlayerCubit() : super(SongPlayerInit()) {
    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.buffering) {
        isBuffering = true;
        emit(SongPlayerBuffering());
      } else if (state == ProcessingState.ready) {
        isBuffering = false;
        emit(SongPlayerUpdated());
      } else {
        emit(SongPlayerLoading());
      }
    });
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });
    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  ///Functions

  void updateSongPlayer() {
    emit(SongPlayerUpdated());
  }

  void updateSliderPosition(double value) {
    songPosition = Duration(seconds: value.toInt());
    updateSongPlayer();
  }

  Future<void> playPlaylist({required int currentIndex, required List<SongEntity> playlist}) async {
    emit(SongPlayerLoading());

    await loadPlaylist(playlist, currentIndex).then((value) {
      currentPlaylist = playlist;
      emit(SongPlayerPlaylistLoaded(playlist, currentIndex));
    }).catchError((error) {
      emit(SongPlayerFailure());
    });
  }

  Future<void> loadPlaylist(List<SongEntity> playlist, int currentIndex) async {
    audioSources = [];
    for (var song in playlist) {
      audioSources.add(AudioSource.uri(
        Uri.parse(song.streamingUrl!),
        tag: MediaItem(
          id: song.songId,
          album: song.artist,
          title: song.title,
          artUri: Uri.parse(song.image!),
        ),
      ));
    }
    await audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: audioSources));
    audioPlayer.seek(Duration.zero, index: currentIndex);
    audioPlayer.play();
    audioPlayer.setLoopMode(LoopMode.all);
  }

  Future<void> playPauseSong() async {
    if (audioPlayer.playing) {
      await audioPlayer.stop();
      emit(SongPlayerPaused());
    } else {
      await audioPlayer.play();
      emit(SongPlayerPlaying());
    }
  }

  Future<void> seekNext() async{
    await audioPlayer.seekToNext();
    emit(SongPlayerNext());
  }

  Future<void> seekPrevious() async{
    await audioPlayer.seekToPrevious();
    emit(SongPlayerPrevious());
  }

  Future<void> seekToPosition(position) async{
    await audioPlayer.seek(position);
    emit(SongPlayerSeek());
  }

  Future<void> shufflePlaylist() async {
    emit(SongPlayerLoading());
    if (audioSources.isNotEmpty && currentPlaylist.isNotEmpty) {
      List<int> indexes = List.generate(currentPlaylist.length, (i) => i);
      indexes.shuffle();
      List<SongEntity> shuffledPlaylist = [];
      List<AudioSource> shuffledAudioSources = [];
      for (int i in indexes) {
        shuffledPlaylist.add(currentPlaylist[i]);
        shuffledAudioSources.add(audioSources[i]);
      }

      currentPlaylist = shuffledPlaylist;
      audioSources = shuffledAudioSources;
      emit(SongPlayerPlaylistLoaded(currentPlaylist, 0));


      await audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: audioSources),
      );
      await audioPlayer.seek(Duration.zero, index: 0);

      emit(SongPlayerPlaylistLoaded(currentPlaylist, 0));
    }
  }

  Future<void> toggleLoopMode() async{
    loopCurrentSong ? loopCurrentSong = false : loopCurrentSong = true;
    loopCurrentSong
        ? await audioPlayer.setLoopMode(LoopMode.one)
        : await audioPlayer.setLoopMode(LoopMode.all);
    emit(SongPlayerUpdated());
  }


  @override
  Future<void> close() async{
    await audioPlayer.dispose();
    return super.close();
  }
}
