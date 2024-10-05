// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongEntityAdapter extends TypeAdapter<SongEntity> {
  @override
  final int typeId = 0;

  @override
  SongEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongEntity(
      songId: fields[0] as String,
      image: fields[1] as String?,
      title: fields[2] as String,
      artist: fields[3] as String?,
      streamingUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SongEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songId)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.artist)
      ..writeByte(4)
      ..write(obj.streamingUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
