import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/widgets/customelevatedbutton.dart';

class WelcomeScreen extends StatefulWidget {
  static String id='WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>  with SingleTickerProviderStateMixin {
  late AnimationController  _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller= AnimationController(vsync: this,
        duration: Duration(seconds: 2));
    animeationfunction();
  }

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  void animeationfunction(){
    if(_controller.isCompleted) {
      _controller.reset();
      animeationfunction();
    }
    else{
      _controller.forward();
      _controller.addListener(() {
        setState(() {
          logoheight = _controller.value*100 ;
        });
      });
    }
  }
  double logoheight=100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: GestureDetector(
                    onTap: (){
                      animeationfunction();
                    },
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: logoheight,
                    ),
                  ),
                ),
               const Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          const  SizedBox(
              height: 48.0,
            ),
            CustomElevatedButton(btnTxt: "Login",
              btnonPress: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
              btnColor: Colors.lightBlueAccent,

            ),
            CustomElevatedButton(btnTxt: "Registration",
                btnonPress: (){
                  Navigator.pushNamed(context, RegistrationScreen.id);
            },
              btnColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }


}
