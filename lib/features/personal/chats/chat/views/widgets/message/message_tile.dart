import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/enums/message/message_type.dart';
import '../../../../../../../core/extension/datetime_ext.dart';
import '../../../../../auth/signin/data/sources/local/local_auth.dart';
import '../../../../../user/profiles/data/sources/local/local_user.dart';
import '../../../../chat_dashboard/domain/entities/messages/message_entity.dart';
import 'tile/alart_message_tile.dart';
import 'tile/offer_message_tile.dart';
import 'tile/visiting_message_tile.dart';
import 'tile/text_message_tile.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({required this.message, required this.timeDiff, super.key});
  final MessageEntity message;
  final Duration? timeDiff;

  @override
  Widget build(BuildContext context) {
    final bool isMe = message.sendBy == LocalAuth.uid;
    return MessageType.invitationParticipant == message.type ||
            MessageType.acceptInvitation == message.type ||
            MessageType.removeParticipant == message.type ||
            MessageType.leaveGroup == message.type
        ? AlartMessageTile(message: message)
        : Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (timeDiff != null && timeDiff!.inMinutes > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FutureBuilder<UserEntity?>(
                    future: LocalUser().user(message.sendBy),
                    initialData: LocalUser().userEntity(message.sendBy),
                    builder: (BuildContext context,
                        AsyncSnapshot<UserEntity?> snapshot) {
                      return RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style:
                              TextStyle(color: Theme.of(context).disabledColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: snapshot.data?.displayName ?? 'na'.tr(),
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text: ' . ${message.createdAt.messageTime}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              MessageType.none == message.type
                  ? TextMessageTile(message: message)
                  : MessageType.text == message.type
                      ? TextMessageTile(message: message)
                      : MessageType.invitationParticipant == message.type ||
                              MessageType.acceptInvitation == message.type ||
                              MessageType.removeParticipant == message.type ||
                              MessageType.leaveGroup == message.type
                          ? AlartMessageTile(message: message)
                          : MessageType.visiting == message.type
                              ? VisitingMessageTile(message: message)
                              : MessageType.offer == message.type
                                  ? OfferMessageTile(message: message)
                                  : Text(
                                      '${message.displayText} - ${message.type?.code.tr()}',
                                    ),
            ],
          );
  }
}
