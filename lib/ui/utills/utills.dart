import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class utills{
  void TosterMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black.withOpacity(.5),
        textColor: Colors.white,
        fontSize: 15.0
    );
  }
}