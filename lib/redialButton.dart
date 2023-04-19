import 'package:animated_radial_menu/animated_radial_menu.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase/BottomNavigator.dart';
import 'package:firebase/ui/auth/login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ReadialButtonScreen extends StatefulWidget {
  const ReadialButtonScreen({super.key});

  @override
  State<ReadialButtonScreen> createState() => _ReadialButtonScreenState();
}

class _ReadialButtonScreenState extends State<ReadialButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RadialMenu(
                  centerButtonAlignment:Alignment.center,
                  centerButtonSize: 0.5,
                  children: [
                  RadialButton(
                    icon: const Icon(Icons.home), buttonColor: Colors.green,
                    onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ConvexAppExample()));

                    }
                    ),
                  RadialButton(
                    icon: const Icon(Icons.add),buttonColor: Colors.orange,
                     onPress: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>const ConvexAppExample()));

                     }
                    ),
                  RadialButton(
                    icon: const Icon(Icons.image),
                    buttonColor: Colors.pink,
                     onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ConvexAppExample()));
                     }
                    ),
                  RadialButton(
                    icon: const Icon(Icons.login_rounded),buttonColor: Colors.blue,
                     onPress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                     }
                    ),
                   
                ]),
            ),
      
          ],
        ),
      ),
    );
  }
}