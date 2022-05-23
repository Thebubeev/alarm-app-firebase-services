import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_alarm_rays7c/models/message_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  static Stream<List<FirestoreUser>> getAllUsers() {
    return FirebaseFirestore.instance.collection('users').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => FirestoreUser.fromJson(doc)).toList());
  }

  static Stream<List<Message>> getAllMessages(chatDocId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatDocId.toString())
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromJson(doc)).toList());
  }

  static Future uploadMessage(
      User user, String id, String message, chatDocId) async {
    final chats = FirebaseFirestore.instance.collection('chats');
    chats.doc(chatDocId).collection('messages').add({
      'createdAt': DateTime.now(),
      'uid': user.uid,
      'message': message,
      'imageUrl': user.photoURL,
      'name': user.displayName
    });
  }
}
