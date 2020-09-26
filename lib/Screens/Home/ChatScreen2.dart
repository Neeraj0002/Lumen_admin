import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/Components/widget.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/constants.dart';
import 'package:lumin_admin/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatAdmin extends StatefulWidget {
  final String chatRoomId;
  final String name;
  ChatAdmin({this.chatRoomId, @required this.name});

  @override
  _ChatAdminState createState() => _ChatAdminState();
}

class _ChatAdminState extends State<ChatAdmin> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  String groupChatId;
  Widget chatMessages() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .orderBy('timestamp', descending: true)
          .limit(50)
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? LayoutBuilder(builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight - 85,
                  child: ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return MessageTile(
                          message:
                              snapshot.data.documents[index].data()['content'],
                          sendByMe: Constants.firebaseId ==
                              snapshot.data.documents[index].data()['idFrom'],
                        );
                      }),
                );
              })
            : Container();
      },
    );
  }

  setChatTo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userId") ?? '';
    Constants.firebaseId = id;
    if (id.hashCode <= widget.chatRoomId.hashCode) {
      groupChatId = '$id-${widget.chatRoomId}';
    } else {
      groupChatId = '${widget.chatRoomId}-$id';
    }
    print(groupChatId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'chattingWith': widget.chatRoomId});
    setState(() {});
  }

  addMessage(String message) {
    if (messageEditingController.text.isNotEmpty) {
      /*Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };*/
      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': Constants.firebaseId,
            'idTo': widget.chatRoomId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': message,
          },
        );
      });

      setState(() {
        messageEditingController.clear();
      });
    } else {
      Fluttertoast.showToast(
          msg: "Nothing to send",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  @override
  void initState() {
    groupChatId = '';
    setChatTo();
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Chat"),
      ),
      body: Container(
        child: Stack(
          children: [
            groupChatId != '' ? chatMessages() : Container(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 24),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: appBarColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: messageEditingController,
                          style: simpleTextStyle(),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              hintText: "Message ...",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      color: appBarColor,
                      onPressed: () {
                        addMessage(messageEditingController.text);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
              )
            ],
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))
                : BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
            color: Colors.white),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'OverpassRegular',
            )),
      ),
    );
  }
}
