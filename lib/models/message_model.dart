import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/utils.dart';

class Message {
  final String uid;
  final String name;
  final String imageUrl;
  final String message;
  final DateTime createdAt;

  Message({this.uid, this.name, this.imageUrl, this.message, this.createdAt});

  static Message fromJson(DocumentSnapshot snapshot) {
    final message = Message(
        uid: snapshot['uid'],
        name: snapshot['name'],
        imageUrl: snapshot['imageUrl'],
        message: snapshot['message'],
        createdAt: Utils.toDateTime(snapshot['createdAt']));
    return message;
  }

  Map<String, Object> toJson() {
    return {
      'uid': uid,
      'name': name,
      'imageUrl': imageUrl,
      'message': message,
      'createdAt': Utils.fromDateTimeToJson(createdAt),
    };
  }
}
