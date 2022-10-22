import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_flutter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';


class ChatScreen extends StatefulWidget {
  static String id='ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   final _auth=FirebaseAuth.instance;
   late User loginUser;

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
      body: SafeArea(
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
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
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
    );
  }
}
