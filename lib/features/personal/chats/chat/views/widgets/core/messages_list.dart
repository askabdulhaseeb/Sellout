import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/utilities/app_string.dart';
import '../../../../chat_dashboard/domain/entities/chat/chat_entity.dart';
import '../../../../chat_dashboard/domain/entities/messages/message_entity.dart';
import '../../../domain/entities/getted_message_entity.dart';
import '../../providers/chat_provider.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (BuildContext context, ChatProvider chatPro, _) {
      final ChatEntity? chat = chatPro.chat;
      return ValueListenableBuilder<Box<GettedMessageEntity>>(
        valueListenable:
            Hive.box<GettedMessageEntity>(AppStrings.localChatMessagesBox)
                .listenable(),
        builder: (BuildContext context, Box<GettedMessageEntity> box, _) {
          final List<GettedMessageEntity> getted = box.values
              .where((GettedMessageEntity e) =>
                  e.lastEvaluatedKey.chatID == chat?.chatId)
              .toList();
          final GettedMessageEntity? last = getted.isEmpty ? null : getted.last;
          final List<MessageEntity> msgs = last?.messages ?? <MessageEntity>[];

          return Flexible(
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: msgs.length,
              itemBuilder: (BuildContext context, int index) {
                final MessageEntity message = msgs[index];
                return Text(message.displayText);
              },
            ),
          );
        },
      );
    });
  }
}
