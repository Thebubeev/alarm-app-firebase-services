import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/firestore_service.dart';
import 'package:flutter_alarm_rays7c/models/user_model.dart';

class Users {
  final String uid;
  final String name;
  final String email;
  final String imageURL;

  Users({@required this.uid, this.name, this.email, this.imageURL});
}

abstract class AuthBase {
  Stream<Users> get authStateChanges;
  Future<Users> currentUser();
  Future<Users> signInAnonymously();
  Future<Users> signInWithEmailAndPassword(String email, String password);
  Future<Users> createUserWithEmailAndPassword(
      String email, String password, String displayName, String photoURL);
  Future<void> resetPasswordUsingEmail(String email);
  Future<void> signOut();
  Future<void> sendVerificationEmail();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  FirestoreService firestoreService;

  //To avoid confusion due to updates, "Users" come from the class Users and "User" replaces the deprecated "FirebaseUser".

  Users _userFromFirebase(User user) {
    if (user == null) {
      print('There is no users with uid');
      return null;
    } else {
      return Users(
          uid: user.uid,
          name: user.displayName,
          email: user.email,
          imageURL: user.photoURL);
    }
  }

  @override
  Future<void> sendVerificationEmail() async {
    final user = _firebaseAuth.currentUser;
    await user.sendEmailVerification();
  }

  @override
  Stream<Users> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<Users> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<Users> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<Users> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<Users> createUserWithEmailAndPassword(String email, String password,
      String displayName, String photoURL) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _firebaseAuth.currentUser.updateDisplayName(displayName);
    await _firebaseAuth.currentUser.updatePhotoURL(photoURL);
    await _firebaseAuth.currentUser.reload();
    final newUser = FirestoreUser(
      idUser: _firebaseAuth.currentUser.uid,
      name: _firebaseAuth.currentUser.displayName,
      email: _firebaseAuth.currentUser.email,
      imageUrl: _firebaseAuth.currentUser.photoURL ??
          'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png',
      lastMessageTime: DateTime.now(),
    );
    await _firestore.collection('users').add(newUser.toMap());
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> resetPasswordUsingEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
