
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
  final messageTextController=TextEditingController();
  final _firetor= FirebaseFirestore.instance;
  late String message;
  final _auth=FirebaseAuth.instance;
    User? loginUser;

    bool userlogined=false;
   bool sending=false;
   var  messages=[];



   void getUser() async{
     try
         {

           final User? user =await _auth.currentUser;
           if(user!=null)
             {
               loginUser=user;
              if(user.email!=null) {
          ElegantNotification.success(
            width: 360,
            notificationPosition: NotificationPosition.topRight,
            animation: AnimationType.fromRight,
            title: Text('Welcome'),
            description: Text('Welcome! ${loginUser?.email}'),
          ).show(context);
              setState(() {
                sending=false;
              });
              }
             }
           else{
             setState(() {
               sending=true;
             });
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
      body: ModalProgressHUD(
        inAsyncCall: sending,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStreams( firetor: _firetor,user: loginUser?.email ?? 'nomail'),
              
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(

                        controller: messageTextController,
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
                          messageTextController.clear();
                          await _firetor.collection("messages").add({
                            'msg': message,
                            'sender': loginUser?.email,
                          });
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

class MessageStreams extends StatelessWidget {
  MessageStreams({required this.firetor, required this.user});
  final String user;
  final firetor;
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: firetor.collection('messages').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
             bool isme= user==data['sender']  ?true : false;
              return messageBubble( data: data,isme: !isme,);
            })
                .toList()
                .cast(),
          ),
        );
      },
    );
  }
}



class messageBubble extends StatelessWidget {
  messageBubble({required this.data,required this.isme});
  final  Map<String, dynamic> data;
 final bool isme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isme? CrossAxisAlignment.start: CrossAxisAlignment.end,
        children: [
          Text(
            data['sender'],
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius:isme? BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)): BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))
           ,
            elevation: 5.0,
            color:isme?  Colors.white:Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                data['msg'],
                style: TextStyle(
                  color:isme? Colors.black: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
