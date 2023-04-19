import 'package:firebase/ui/auth/verify_code.dart';
import 'package:firebase/ui/utills/utills.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phonenumberControllerr = TextEditingController();
  final auth =FirebaseAuth.instance;
  bool  loading=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Login With Phone Number'),
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
              decoration: InputDecoration(
                hintText: "+91 12345 67890"
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(title: 'login', loading: loading,
            onPress: (){
              setState(() {
                 loading =true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phonenumberControllerr.text,
                verificationCompleted: (_){
                  setState(() {
                    loading =false;
                  });
      
                }, 
                verificationFailed: (e){
                  utills().TosterMessage(e.toString());
                  setState(() {
                    loading=false;
                  });
                }, 
                codeSent: (String VerificationId, int ? token){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCodeScreen(VerificationId: VerificationId,)));
                  setState(() {
                    loading=false;
                  });
      
                }, 
                codeAutoRetrievalTimeout: (e){
                  utills().TosterMessage(e.toString());
                  setState(() {
                    loading=false;
                  });
                });
      
            })
          ],
        ),
      ),
    );
  }
}