import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../config/utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class FirestoreUser extends Equatable {
   String idUser;
  final String name;
  final String email;
  final String imageUrl;
  final DateTime lastMessageTime;
  FirestoreUser(
      {this.idUser,
      this.name,
      this.email,
      this.imageUrl,
      this.lastMessageTime});

  static FirestoreUser fromJson(DocumentSnapshot snapshot) {
    FirestoreUser firestoreUser = FirestoreUser(
        idUser: snapshot['idUser'],
        name: snapshot['name'],
        email: snapshot['email'],
        imageUrl: snapshot['photoURL'],
        lastMessageTime: Utils.toDateTime(snapshot['lastMessageTime']));
    return firestoreUser;
  }

  Map<String, Object> toMap() {
    return {
      'idUser': idUser,
      'name': name,
      'email': email,
      'photoURL': imageUrl,
      'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
    };
  }

  @override
  List<Object> get props => [idUser, name, email, imageUrl, lastMessageTime];
}
