import 'package:flutter/material.dart';

class CustomTextFieldElevatedBorder extends StatelessWidget {
  CustomTextFieldElevatedBorder({required this.txtOnChange,this.txtHint='',
    this.txtBorderRadius=32.0,
  this.txtContentPaddingHorizontal=20.0,this.txtContentPaddingVerticle=10.0,
  this.txtEnableBorderOutlineColor=Colors.lightBlueAccent,
  this.txtFocusedBorderOutlineColor=Colors.lightBlueAccent
  , this.txtEnableBorderOutlineRadius=32.0,
  this.txtEnableBorderOutlineWidth=1.0,
  this.txtFocusedBorderOutlineRadius=32.0
  , this.txtFocusedBorderOutlineWidth=.0
  , this.txtAlign= TextAlign.center, this.txtKeyBoardType = TextInputType.text,
    this.txtObsure=false,
  });

 final String txtHint;
 final Function(String) txtOnChange;
 final double txtBorderRadius;

 final double txtContentPaddingHorizontal;
 final double txtContentPaddingVerticle;

 final Color txtFocusedBorderOutlineColor;
 final double txtFocusedBorderOutlineWidth;
 final double txtFocusedBorderOutlineRadius;

 final Color txtEnableBorderOutlineColor;
 final double txtEnableBorderOutlineWidth;
 final double txtEnableBorderOutlineRadius;

 final TextInputType txtKeyBoardType;
 final bool txtObsure;
 final TextAlign txtAlign;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: txtKeyBoardType,
      obscureText: txtObsure,
      textAlign: txtAlign,
      onChanged: txtOnChange,
      decoration: InputDecoration(
        hintText: txtHint,
        fillColor: Colors.white,
        focusColor: Colors.blue,
        filled: true,
        contentPadding:
        EdgeInsets.symmetric(vertical: txtContentPaddingVerticle, horizontal: txtContentPaddingHorizontal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(txtBorderRadius)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: txtEnableBorderOutlineColor, width: txtEnableBorderOutlineWidth),
          borderRadius: BorderRadius.all(Radius.circular(txtEnableBorderOutlineRadius)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: txtFocusedBorderOutlineColor, width: txtFocusedBorderOutlineWidth),
          borderRadius: BorderRadius.all(Radius.circular(txtEnableBorderOutlineRadius)),
        ),

      ),
    );
  }
}
