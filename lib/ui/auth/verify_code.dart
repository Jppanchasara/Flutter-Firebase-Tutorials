

import 'package:firebase/BottomNavigator.dart';
import 'package:firebase/ui/Post/post_screen.dart';
import 'package:firebase/ui/utills/utills.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String VerificationId;
  const VerifyCodeScreen({super.key,required this.VerificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
 final phonenumberControllerr = TextEditingController();
  final auth =FirebaseAuth.instance;
  bool  loading=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  const Text('Verify'),
        backgroundColor: Colors.purple,
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(
              controller: phonenumberControllerr,
              decoration: const InputDecoration(
                hintText: "6 Digits Number"
              ),
            ),
            const Text('Code is 1 Miniutes avelaible'),
            const SizedBox(height: 30,),
            RoundButton(title: 'verify', loading: loading,
            onPress: ()async{
              final credential=PhoneAuthProvider.credential(
                verificationId: widget.VerificationId, 
                smsCode: phonenumberControllerr.text.toString()
              );

              try{
                await auth.signInWithCredential(credential);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ConvexAppExample()));

              }
              catch(e){
                utills().TosterMessage(e.toString());

              }
      
            })
          ],
        ),
      ),
    );
  }
}