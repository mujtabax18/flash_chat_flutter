import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/widgets/customelevatedbutton.dart';
import 'package:flash_chat_flutter/widgets/customtextfieldelevatedborder.dart';

class RegistrationScreen extends StatefulWidget {
  static String id='RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            CustomTextFieldElevatedBorder(txtOnChange: (value){},txtHint: 'Enter Your Email',),
            const SizedBox(
              height: 8.0,
            ),
            CustomTextFieldElevatedBorder(txtOnChange: (value){},txtHint: 'Enter Your Password',),
            const SizedBox(
              height: 24.0,
            ),
        CustomElevatedButton(btnTxt: "Register",
          btnonPress: (){
          },
          btnColor: Colors.blueAccent,
        ),
          ],
        ),
      ),
    );
  }
}
