import 'package:firebase/ui/auth/login_Screen.dart';
import 'package:firebase/ui/utills/utills.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading =false;
 
 final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Sign Up '),
        backgroundColor: Colors.purple,
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children:<Widget> [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.alternate_email_outlined)
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                      
                      
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'password',
                          prefixIcon: Icon(Icons.lock)),
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                      
                    ),
                  ],
                )),
            const SizedBox(
              height: 35,
            ),
            RoundButton(
              loading: loading,
              title: "SignUp",
              onPress: () {
                if(_formKey.currentState!.validate()){
                  setState(() {
                    loading= true;
                  });
                  _auth.createUserWithEmailAndPassword(
                    email: emailController.text.toString(),
                     password: passwordController.text.toString()
                  ).then((value) {
                    utills().TosterMessage('Sign Up Scussessfully');
                    setState(() {
                    loading= false;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                  }).onError((error, stackTrace){
                    setState(() {
                    loading= false;
                    });
                    utills().TosterMessage(error.toString());
                  });

                }
               
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("already have an account?"),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }, 
                  child: Text("Login ",style: TextStyle(fontWeight: FontWeight.bold),))
              ],
            )
          ],
        ),
      ),
    );
  }
}