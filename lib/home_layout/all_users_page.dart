import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/firestore_service.dart';
import 'package:flutter_alarm_rays7c/home_layout/chat_page.dart';
import 'package:flutter_alarm_rays7c/models/user_model.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({Key key}) : super(key: key);

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('All users'),
          centerTitle: true,
        ),
        body: StreamBuilder<List<FirestoreUser>>(
          stream: FirestoreService.getAllUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Center(
                                child: Container(
                              width: 160,
                              height: 160,
                              child: CachedNetworkImage(
                                  imageUrl: currentUser.photoURL ??
                                      'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png'),
                            )),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            currentUser.displayName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            currentUser.email,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                          user: snapshot.data[index],
                                          friendName: snapshot.data[index].name,
                                          friendUid: snapshot.data[index].idUser,
                                        )));
                          },
                          title: Text(snapshot.data[index].name),
                          subtitle: Text(snapshot.data[index].email),
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                  width: 45,
                                  height: 45,
                                  child: CachedNetworkImage(
                                    placeholder: (context, _) =>
                                        CircularProgressIndicator(),
                                    imageUrl: snapshot.data[index].imageUrl ??
                                        'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png',
                                  ))),
                        );
                      },
                      itemCount: snapshot.data.length,
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong...'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
