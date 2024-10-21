import 'dart:developer';

import 'package:hive/hive.dart';

part 'message_type.g.dart';

@HiveType(typeId: 18)
enum MessageType {
  @HiveField(0)
  text('text', 'text'),
  @HiveField(1)
  image('image', 'image'),
  @HiveField(2)
  video('video', 'video'),
  @HiveField(3)
  audio('audio', 'audio'),
  @HiveField(4)
  file('file', 'file'),
  @HiveField(5)
  location('location', 'location'),
  @HiveField(6)
  contact('contact', 'contact'),
  @HiveField(7)
  sticker('sticker', 'sticker'),
  @HiveField(8)
  custom('custom', 'custom'),
  @HiveField(9)
  invitationParticipant('invitation-participant', 'invitation_participant'),
  @HiveField(10)
  offer('offer', 'offer'),
  @HiveField(11)
  visiting('visiting', 'visiting'),
  @HiveField(12)
  acceptInvitation('accept-invitation', 'accept_invitation'),
  @HiveField(13)
  removeParticipant('remove-participant', 'remove_participant'),
  @HiveField(14)
  leaveGroup('leave-group', 'leave_group'),
  @HiveField(99)
  none('none', 'none');

  // visiting,
  const MessageType(this.code, this.json);
  final String code;
  final String json;

  static MessageType fromJson(String? value) {
    if (value != null &&
        value != 'invitation_participant' &&
        value != 'accept_invitation' &&
        value != 'remove_participant' &&
        value != 'offer' &&
        value != 'visiting' &&
        value != 'leave_group') {
      log('MessageType.fromvalue: $value');
    }
    if (value == null) {
      return MessageType.text;
    }
    return values.firstWhere((MessageType e) => e.json == value,
        orElse: () => MessageType.text);
  }
}
