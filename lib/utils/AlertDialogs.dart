import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_dbms/utils/Loaders.dart';


/// Alert dialog to show Errors
showErrorAlert(BuildContext context, String title, String message) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
      btnCancelColor: Colors.deepOrangeAccent, 
      btnOkColor: Colors.black26,
      buttonsTextStyle: TextStyle(
          fontFamily: "Brand Regular", fontSize: 14, color: Color(0XFFFFFFFF)))
    ..show();
}

/// Alert dialog to show Information
showInfoAlert(BuildContext context, String title, String message) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
      btnCancelColor: Colors.deepOrangeAccent,
      btnOkColor: Colors.black38,
      buttonsTextStyle: TextStyle(
          fontFamily: "Brand Regular", fontSize: 14, color: Colors.green))
    ..show();
}

/// Alert dialog to show Information
showSuccessAlert(BuildContext context, String title, String message) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
      btnCancelColor: Colors.deepOrangeAccent,
      btnOkColor: Colors.black38,
      buttonsTextStyle: TextStyle(
          fontFamily: "Brand Regular", fontSize: 14, color: Color(0XFFFFFFFF)))
    ..show();
}

showProgressDialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 80,
            child: Row(
              children: [
                loaderOne,
                Expanded(child: Text(message)),
              ],
            ),
          ),
        );
      });
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
