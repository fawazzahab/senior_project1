import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';
import 'package:flutter_auth/volunteer/volunteer_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class VChatPage extends StatefulWidget {
  final docs;
  const VChatPage({ this.docs}) ;

  @override
  _VChatPageState createState() => _VChatPageState();
}

class _VChatPageState extends State<VChatPage> {

  String groupChatId;
  String userID;

  TextEditingController textEditingController = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getGroupChatId();
    super.initState();
  }


  getGroupChatId() async {
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    User user = FirebaseAuth.instance.currentUser;
    userID = user.uid;

    //userID = sharedPreferences.getString('uid');


    String anotherUserId = widget.docs['uid'];


    if (userID.compareTo(anotherUserId) > 0) {
      groupChatId = '$userID - $anotherUserId';
    } else {
      groupChatId = '$anotherUserId - $userID';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String otherEmail = widget.docs['email'];
    final FirebaseFirestore _Firestore= FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('' +otherEmail ,),
        backgroundColor: appbarcolor,
      ),
      drawer: volunteer_drawer(),

      body: StreamBuilder<QuerySnapshot>(
        stream: _Firestore
            .collection('messages')
            .doc(groupChatId)
            .collection(groupChatId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemBuilder: (listContext, index) =>
                          buildItem(snapshot.data.docs[index]),
                      itemCount: snapshot.data.docs.length,
                      reverse: true,
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: new InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                              width: 2,
                            ),
                          ),
                          //hintText: 'Enter Your Message !',
                          labelText: 'Chat ! ',
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          sendMsg();
                          textEditingController.clear();
                        }
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ));
          }
        },
      ),
    );
  }

  sendMsg() {
    final FirebaseFirestore _Firestore= FirebaseFirestore.instance;
    String msg = textEditingController.text.trim();
    /// Upload images to firebase and returns a URL
    if (msg.isEmpty) {
      print('Please enter some text to send');
    } else {
      print('thisiscalled $msg');
      var ref = _Firestore
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      _Firestore.runTransaction((transaction) async {
        await transaction.set(ref, {
          "senderId": userID,
          "anotherUserId": widget.docs['uid'],
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          'content': msg,
          "type": 'text',
        });
      });

      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);

    }
  }

  buildItem(doc) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: ((doc['senderId'] == userID) ? 64 : 0),
          right: ((doc['senderId'] == userID) ? 0 : 64)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        margin: (
            new EdgeInsets.symmetric(horizontal: 20.0)
        ),
        decoration: BoxDecoration(
            color: ((doc['senderId'] == userID)
                ? Colors.grey
                : Colors.greenAccent),
            borderRadius: BorderRadius.circular(8.0)),
        child: (doc['type'] == 'text')
            ? Text('${doc['content']}')
            : Image.network(doc['content']),
      ),
    );
  }
}
