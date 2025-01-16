import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/extension/datetime_ext.dart';
import '../../../../../../../../core/widgets/custom_network_image.dart';
import '../../../../../../../../core/widgets/shadow_container.dart';
import '../../../../../../post/data/sources/local/local_post.dart';
import '../../../../../../post/domain/entities/post_entity.dart';
import '../../../../../chat_dashboard/domain/entities/messages/message_entity.dart';

class VisitingMessageTile extends StatelessWidget {
  const VisitingMessageTile({required this.message, super.key});
  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    const TextStyle boldStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    return FutureBuilder<PostEntity?>(
        future: LocalPost().getPost(message.visitingDetail?.postID ??
            message.offerDetail?.post.postId ??
            ''),
        builder: (BuildContext context, AsyncSnapshot<PostEntity?> snapshot) {
          final PostEntity? post = snapshot.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ShadowContainer(
              child: Column(
                children: <Widget>[
                  Opacity(
                    opacity: 0.6,
                    child: const Text(
                      'your_booking_details',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ).tr(),
                  ),
                  Text(
                    '${'you_are_booked_in_for_a_visiting_on'.tr()}:',
                    style: boldStyle,
                  ),
                  Text(
                    message.visitingDetail?.dateTime.dateWithMonthOnly ??
                        'Date not set',
                    style: boldStyle,
                  ),
                  Text(
                    message.visitingDetail?.visitingTime ?? 'Time not set',
                    style: boldStyle,
                  ),
                  const Text(
                    'we_looke_forward_to_seeing_you',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ).tr(),
                  const SizedBox(height: 12),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CustomNetworkImage(
                          imageURL: message.offerDetail?.post.imageURL ??
                              post?.fileUrls.first.url ??
                              '',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          message.offerDetail?.post.title ??
                              post?.title ??
                              'na',
                          style: boldStyle,
                        ),
                      ),
                      Text(
                        '${message.offerDetail?.post.currency ?? post?.currency} ${message.offerDetail?.post.price ?? post?.price}',
                        style: boldStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Opacity(
                      opacity: 0.6,
                      child: Text(message.createdAt.timeAgo),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
