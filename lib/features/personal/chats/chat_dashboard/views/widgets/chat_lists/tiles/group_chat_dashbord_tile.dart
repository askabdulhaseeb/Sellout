import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../core/extension/datetime_ext.dart';
import '../../../../../../../../core/widgets/profile_photo.dart';
import '../../../../../../../../core/widgets/shadow_container.dart';
import '../../../../../chat/views/providers/chat_provider.dart';
import '../../../../../chat/views/screens/chat_screen.dart';
import '../../../../domain/entities/chat/chat_entity.dart';

class GroupChatDashbordTile extends StatelessWidget {
  const GroupChatDashbordTile({required this.chat, super.key});
  final ChatEntity chat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ShadowContainer(
        onTap: () {
          Provider.of<ChatProvider>(context, listen: false).chat = chat;
          Navigator.of(context).pushNamed(ChatScreen.routeName);
        },
        child: Row(
          children: <Widget>[
            ProfilePhoto(
              url: chat.groupInfo?.groupThumbnailURL,
              isCircle: true,
              placeholder: chat.groupInfo?.title ?? '',
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    chat.groupInfo?.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    chat.lastMessage?.displayText ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              chat.lastMessage?.createdAt.timeAgo ?? '',
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
