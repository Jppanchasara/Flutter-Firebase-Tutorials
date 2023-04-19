import 'package:firebase/ui/auth/login_Screen.dart';
import 'package:firebase/ui/utills/utills.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController=TextEditingController();
  final auth =FirebaseAuth.instance;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Forgot Password'),
          backgroundColor: Colors.purple,
          centerTitle: true,
          automaticallyImplyLeading: true,
          elevation: 10,
        ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          
          children: [
            
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email'
              ),
            ),
            SizedBox(height: 50,),
            
            RoundButton(
              loading: loading,
              title: 'Forget Password', onPress: (){
              setState(() {
                loading=true;
              });
              auth.sendPasswordResetEmail(
                email: emailController.text.toString()
                ).then((value) {
                  setState(() {
                    loading=false;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  utills().TosterMessage('We have send you to recover password please checck email');

              }).onError((error, stackTrace) {
                setState(() {
                  loading=false;
                });
                utills().TosterMessage(error.toString());

              });
      
            })
          ],
        ),
      ),
    );
  }
}