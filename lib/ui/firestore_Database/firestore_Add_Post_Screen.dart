import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/ui/firestore_Database/firestore_list_screen.dart';
import 'package:firebase/ui/utills/utills.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

class FirestoreAddPostScreen extends StatefulWidget {
  const FirestoreAddPostScreen({super.key});

  @override
  State<FirestoreAddPostScreen> createState() => _FirestoreAddPostScreenState();
}

class _FirestoreAddPostScreenState extends State<FirestoreAddPostScreen> {
  final String id = DateTime.now().microsecondsSinceEpoch.toString();
  firebase_storage.FirebaseStorage storage =firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseref= FirebaseDatabase.instance.ref('post');
  
  final addpostController = TextEditingController();
  final pincodeController = TextEditingController();
  final  firestore =FirebaseFirestore.instance.collection('post');
  final _formKey = GlobalKey<FormState>();
     DateTime now = DateTime.now();


  File? _image;
  final Picker = ImagePicker();

  Future getImageUploaded() async {
    final PickedFile =
        await Picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('No image picked');
      }
    });
  }
  Future getImageCameraUploaded() async {
    final PickedFile =
        await Picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('No image picked');
      }
    });
  }
   

  
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      body: SingleChildScrollView(
        child: Padding(
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
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              getImageUploaded();
                            },
                            child: Container(
                              height: 200,
                              width: 270,
                              decoration:
                                  BoxDecoration(border: Border.all(color: Colors.black)),
                              child: _image != null
                                  ? Image.file(_image!.absolute)
                                  : const Center(
                                      child: Icon(
                                      Icons.image,
                                      size: 70,
                                    )),
                            ),
                          ),
                          Column(
                            
                            children: [
                              
                              IconButton(
                                onPressed: (){
                                  getImageUploaded();
      
                                }, icon:Icon(Icons.camera,color: Colors.purple,size: 40,)
                                ),
                                SizedBox(height: 10,),
                              IconButton(
                                  onPressed: (){
                                    getImageCameraUploaded();
                                    
                                  }, icon: Icon(Icons.photo_camera,color: Colors.purple,size: 40,)
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      
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
                    setState(() {
                      loading=true;
                    });
                    
                    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/image/'+id);
                firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
      
                 Future.value(uploadTask).then((value) async{
                  var newurl= await ref.getDownloadURL();
                  firestore.doc(id).set({
                      'Address':addpostController.text.toString(),
                      'pincode':pincodeController.text.toString(),
                      'id':id.toString(),
                      'photos':newurl.toString(),
                      'time': now.toLocal().toString().split(' ')[0].toString()
                      
      
                    }).then((value) {
                      setState(() {
                        loading=false;
                      });
                      utills().TosterMessage('post Added');
      
                    }).onError((error, stackTrace) {
                      setState(() {
                        
                        loading=false;
                      });
                      utills().TosterMessage(error.toString());
      
                    });
      
                });
      
      
      
                    
                    
                  }),
            ],
          ),
        ),
      ),
    );
  }
}