// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataAdapterAdapter extends TypeAdapter<UserDataAdapter> {
  @override
  final int typeId = 1;

  @override
  UserDataAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataAdapter(
      name: fields[0] as String,
      cellphone: fields[1] as String,
      avatar: fields[3] as String,
      isAvatar: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserDataAdapter obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cellphone)
      ..writeByte(3)
      ..write(obj.avatar)
      ..writeByte(4)
      ..write(obj.isAvatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
