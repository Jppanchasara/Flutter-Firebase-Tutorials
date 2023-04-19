
import 'dart:async';

import 'package:firebase/ui/auth/login_Screen.dart';
import 'package:firebase/ui/firestore_Database/firestore_list_screen.dart';
import 'package:firebase/ui/image_upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../BottomNavigator.dart';
import '../ui/Post/post_screen.dart';


class SplashServices{
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user =auth.currentUser;

    if(user!=null){
      Timer(const Duration(seconds: 5), () =>
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ConvexAppExample())) 

      );

    }else{
      Timer(const Duration(seconds: 5), () =>
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())) 

      );

    }
    
    

  }
}