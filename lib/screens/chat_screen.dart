import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';


class ChatScreen extends StatefulWidget {

  static String id='ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStor=FirebaseFirestore.instance;
  late String message;
  final _auth=FirebaseAuth.instance;
   late User loginUser;
   bool sending=false;
   var  messages=[];
   void getUser() async{
     try
         {
           final user =await _auth.currentUser;
           if(user!=null)
             {
               loginUser=user;
               ElegantNotification.success(
                 width: 360,
                 notificationPosition: NotificationPosition.topRight,
                 animation: AnimationType.fromRight,
                 title: Text('Welcome'),
                 description: Text('Welcome! ${loginUser.email}'),
               ).show(context);
             }
         }
         catch(e)
     {
       ElegantNotification.error(
         width: 360,
         notificationPosition: NotificationPosition.topRight,
         animation: AnimationType.fromRight,
         title: Text('Error'),
         description: Text(e.toString()),
       ).show(context);
     }
   }

  void getMessagesData()async{
 await  for(var snapshot in _fireStor.collection('messages').snapshots()) {
      for (var data1 in snapshot.docs) {
        print(data1.data());
      }
    }

  }



   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _auth.signOut();
    getMessagesData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: sending,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          message=value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () async{
                        setState(() {
                          sending=true;
                        });
                        try{
                          await _fireStor.collection("messages").add({
                            'msg': message,
                            'sender': loginUser.email,
                          });
                         // getMessagesData();
                        }
                        catch(e){
                          setState(() {
                            sending=false;
                          });
                          ElegantNotification.error(
                            width: 360,
                            notificationPosition: NotificationPosition.topRight,
                            animation: AnimationType.fromRight,
                            title: Text('Error'),
                            description: Text(e.toString()),
                          ).show(context);
                        }
                        setState(() {
                         sending=false;
                       });
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
