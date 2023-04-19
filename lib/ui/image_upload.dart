import 'dart:io';

import 'package:firebase/ui/utills/utills.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';


class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final String id = DateTime.now().microsecondsSinceEpoch.toString();
  firebase_storage.FirebaseStorage storage =firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseref= FirebaseDatabase.instance.ref('Post');
  bool loading=false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
        backgroundColor: Colors.purple,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 10,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    getImageUploaded();
                  },
                  child: Container(
                    height: 200,
                    width: 250,
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
            SizedBox(
              height: 50,
            ),
            RoundButton(title: 'Upload',loading: loading, onPress: () async{
              setState(() {
                loading=true;
              });
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/image'+'1243');
              firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

               Future.value(uploadTask).then((value) async{
                var newurl= await ref.getDownloadURL();

              databaseref.child(id).set({
                'photos':newurl.toString(),
                'id': id.toString()
              }).then((value) {
                utills().TosterMessage('Sucssefully added');
                setState(() {
                  loading=false;
                });

              }).onError((error, stackTrace) {
                utills().TosterMessage(error.toString());
                setState(() {
                  loading=false;
                });

              });

              }).onError((error, stackTrace) {
                utills().TosterMessage(error.toString());
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
