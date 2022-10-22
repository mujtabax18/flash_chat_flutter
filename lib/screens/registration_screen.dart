import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/widgets/customelevatedbutton.dart';
import 'package:flash_chat_flutter/widgets/customtextfieldelevatedborder.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';

class RegistrationScreen extends StatefulWidget {
  static String id='RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
final _auth=FirebaseAuth.instance;
late String email;
late String password;
bool loading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              CustomTextFieldElevatedBorder(txtOnChange: (value){
                email=value;
              },
                txtHint: 'Enter Your Email',
              txtKeyBoardType: TextInputType.emailAddress,),
              const SizedBox(
                height: 8.0,
              ),
              CustomTextFieldElevatedBorder(txtOnChange: (value){
                password=value;
              },txtHint: 'Enter Your Password',
              txtObsure: true,
              ),
              const SizedBox(
                height: 24.0,
              ),
          CustomElevatedButton(btnTxt: "Register",
            btnonPress: ()async{
            setState(() {
              loading=true;
            });
            try {

             final newUser= await _auth.createUserWithEmailAndPassword(
                  email: email, password: password);
             setState(() {
               loading=false;
             });
             if( newUser!=null) {
               Navigator.pushNamed(context, ChatScreen.id);
             }
            }
            catch(e)
              {
                setState(() {
                  loading=false;
                });
                ElegantNotification.error(
                    width: 360,
                    notificationPosition: NotificationPosition.topRight,
                    animation: AnimationType.fromRight,
                    title: Text('Error'),
                    description: Text(e.toString()),
                  ).show(context);
            }

            },
            btnColor: Colors.blueAccent,
          ),
            ],
          ),
        ),
      ),
    );
  }
}
