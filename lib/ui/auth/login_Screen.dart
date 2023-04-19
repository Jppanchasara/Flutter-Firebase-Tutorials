import 'package:firebase/ui/Post/post_screen.dart';
import 'package:firebase/ui/auth/forgot_password.dart';
import 'package:firebase/ui/auth/login_with_phone.dart';
import 'package:firebase/ui/auth/signup_Screen.dart';
import 'package:firebase/ui/firestore_Database/firestore_list_screen.dart';
import 'package:firebase/ui/utills/utills.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../BottomNavigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn=GoogleSignIn();
  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });

    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      utills().TosterMessage('login scussefully');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  FireStoreListScreen()));
      utills().TosterMessage(value.user!.email.toString());
    }).onError((error, stackTrace) {
      utills().TosterMessage(error.toString());
      setState(() {
        loading = false;
      });
      debugPrint(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Colors.purple,
          centerTitle: true,
          automaticallyImplyLeading: false,
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
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email_outlined)),
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
                            hintText: 'password', prefixIcon: Icon(Icons.lock)),
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
                title: "Login",
                loading: loading,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()));
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't have your account"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConvexAppExample()));
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithPhoneNumber()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.purple,
                      )),
                  child: Center(
                      child: Text(
                    'Login with Phone Number',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
          
                  SignInGoogle();
                   },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.purple,
                      )),
                  child: Center(
                      child: Text(
                    'Login with Google',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  SignInGoogle()async{
    GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;

    AuthCredential credential=GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );
    UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
    print(userCredential.user?.phoneNumber);
    if(userCredential.user != Null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ConvexAppExample()));

    }
  }
}
