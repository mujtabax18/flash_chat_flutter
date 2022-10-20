import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({required this.btnTxt,this.btnColor=Colors.blue,required this.btnonPress,
  this.btnBorderRadius = 30.0,this.btnElevation=5.0,this.btnVerticalPadding=16.0,
  this.btnHeight=42.0,this.btnMinWidth=200.0});
  String btnTxt;
  Color btnColor;
  final VoidCallback btnonPress;
  final double btnBorderRadius;
  final double btnElevation;
  final double btnVerticalPadding;
  final double btnMinWidth;
  final double btnHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: btnVerticalPadding),
      child: Material(
        color: btnColor,
        borderRadius: BorderRadius.circular(btnBorderRadius),
        elevation: btnElevation,
        child: MaterialButton(
          onPressed:btnonPress,
          minWidth: btnMinWidth,
          height: btnHeight,
          child: Text(
            btnTxt,
          ),
        ),
      ),
    );
  }
}
