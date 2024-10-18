// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatTypeAdapter extends TypeAdapter<ChatType> {
  @override
  final int typeId = 28;

  @override
  ChatType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ChatType.private;
      case 1:
        return ChatType.product;
      case 2:
        return ChatType.group;
      default:
        return ChatType.private;
    }
  }

  @override
  void write(BinaryWriter writer, ChatType obj) {
    switch (obj) {
      case ChatType.private:
        writer.writeByte(0);
        break;
      case ChatType.product:
        writer.writeByte(1);
        break;
      case ChatType.group:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
