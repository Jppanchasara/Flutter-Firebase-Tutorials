import 'package:firebase/ui/Post/post_screen.dart';
import 'package:firebase/ui/utills/utills.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_database/firebase_database.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final addpostController = TextEditingController();
  final pincodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   DateTime now = DateTime.now();

  final String id = DateTime.now().microsecondsSinceEpoch.toString();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
        backgroundColor: Colors.purple,
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: addpostController,
                      keyboardType: TextInputType.streetAddress,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'Address',
                        border: OutlineInputBorder(),
                      ),
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
                      keyboardType: TextInputType.number,
                      controller: pincodeController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: 'Your Pincode Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                loading: loading,
                title: 'Add',
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    databaseRef.child(id).set({
                      'id':id,
                      'Address': addpostController.text.toString(),
                      'pincode': pincodeController.text.toString(),
                      'time': now.toLocal().toString().split(' ')[0].toString()
                    }).then((value) {
                      setState(() {
                        loading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostScreen()));
                      utills().TosterMessage('you data is scussefully added');
                      print(id);
                    }).onError((error, stackTrace) {
                      setState(() {
                        loading = false;
                      });
                      utills().TosterMessage(error.toString());
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
