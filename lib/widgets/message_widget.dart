import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/models/user_model.dart';

import '../models/message_model.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;
  final FirestoreUser user;

  const MessageWidget(
      {@required this.message, @required this.isMe, @required this.user});

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!isMe)
          CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              backgroundImage: CachedNetworkImageProvider(user.imageUrl)),
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          constraints: BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[100] : Theme.of(context).accentColor,
            borderRadius: isMe
                ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.message,
            style: TextStyle(color: isMe ? Colors.black : Colors.white),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
          ),
        ],
      );
}
