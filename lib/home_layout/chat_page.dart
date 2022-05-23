import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/models/user_model.dart';
import 'package:flutter_alarm_rays7c/widgets/build_text_widget.dart';

import '../Services/firestore_service.dart';
import '../models/message_model.dart';
import '../widgets/message_widget.dart';

class ChatPage extends StatefulWidget {
  final friendUid;
  final friendName;
  final FirestoreUser user;
  const ChatPage({Key key, this.user, this.friendName, this.friendUid})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  String message = '';

  final currentUserUid = FirebaseAuth.instance.currentUser.uid;
  final currentUser = FirebaseAuth.instance.currentUser;

  var chatDocId;
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  Future<void> checkUser() async {
    await chats
        .where('users',
            isEqualTo: {widget.friendUid: null, currentUserUid: null})
        .limit(1)
        .get()
        .then((snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            setState(() {
              chatDocId = snapshot.docs.single.id;
            });
            print('-------chatDocId: $chatDocId');
          } else {
            await chats.add({
              'users': {currentUserUid: null, widget.friendUid: null}
            }).then((value) {
              chatDocId = value;
            });
          }
        })
        .catchError((error) {});
  }

  Future<void> sendMessage() async {
    FocusScope.of(context).unfocus();

    await FirestoreService.uploadMessage(
        currentUser, widget.user.idUser, message, chatDocId);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          titleSpacing: 0.6,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 12),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        color: Colors.white,
                        width: 40,
                        height: 40,
                        child: CachedNetworkImage(
                            imageUrl: widget.user.imageUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator()))),
              ),
              Text(widget.user.name),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.call,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.video_call),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            )
          ]),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: StreamBuilder<List<Message>>(
                stream: FirestoreService.getAllMessages(chatDocId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return buildText('Something Went Wrong');
                  }
                  if (snapshot.hasData) {
                    final messages = snapshot.data;
                    return messages.isEmpty
                        ? buildText('Say hi...')
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return MessageWidget(
                                  message: message,
                                  isMe: message.uid == currentUser.uid,
                                  user: widget.user);
                            },
                          );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          )),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: SafeArea(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Type your message',
                      ),
                      onChanged: (value) => setState(() {
                        message = value;
                      }),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: message.trim().isEmpty ? null : sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
