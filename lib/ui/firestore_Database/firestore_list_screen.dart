import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/ui/firestore_Database/firestore_Add_Post_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

import '../auth/login_Screen.dart';
import '../utills/utills.dart';

class FireStoreListScreen extends StatefulWidget {
 
   const FireStoreListScreen({super.key,});

  @override
  State<FireStoreListScreen> createState() => _FireStoreListScreenState();
}

class _FireStoreListScreenState extends State<FireStoreListScreen> {
  final firestore = FirebaseFirestore.instance.collection('post').snapshots();
  final updateEditController = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('post');
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
        children: [
          
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Text('some error');
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final title =
                            snapshot.data!.docs[index]['Address'].toString();
                        final String st =
                            snapshot.data!.docs[index]['photos'].toString();

                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            child:Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image(
                                      height: 250,
                                      
                                      image: NetworkImage(st),
                                      fit: BoxFit.fill,
                                    ), 
                                    
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 35,
                                                child: Lottie.asset("image/Lottie/location.json"),
                                              )
                                              ,
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(snapshot.data!
                                                    .docs[index]['Address']
                                                    .toString()),
                                              ),
                                              PopupMenuButton(
                                                  child: const Icon(
                                                    Icons.more_vert,
                                                    size: 30,
                                                  ),
                                                  itemBuilder: (context) => [
                                                        PopupMenuItem(
                                                            value: 1,
                                                            child: ListTile(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                showMyDialogBox(
                                                                    title,
                                                                    snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                            [
                                                                            'id']
                                                                        .toString());
                                                              },
                                                              trailing: const Icon(
                                                                  Icons.edit),
                                                              title:
                                                                  const Text('Edit'),
                                                            )),
                                                        PopupMenuItem(
                                                            value: 2,
                                                            child: ListTile(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                ref
                                                                    .doc(snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                            [
                                                                            'id']
                                                                        .toString())
                                                                    .delete();
                                                                
                                                              },
                                                              trailing: const Icon(
                                                                  Icons.delete),
                                                              title: const Text(
                                                                  'Delete'),
                                                            )),
                                                      ]),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,
                                                child: const Icon(Icons.build)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(snapshot.data!
                                                    .docs[index]['pincode']
                                                    .toString()),
                                              ),
                                              Text(snapshot
                                                  .data!.docs[index]['time']
                                                  .toString())
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
        ],
      ),
      
    );
  }

  Future<void> showMyDialogBox(String title, String id) async {
    updateEditController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.doc(id).update({
                      'Address': updateEditController.text.toLowerCase()
                    }).then((value) {
                      utills().TosterMessage('Post Updated');
                    }).onError((error, stackTrace) {
                      utills().TosterMessage(error.toString());
                    });
                  },
                  child: const Text('Update'))
            ],
            content: Container(
              child: TextFormField(
                controller: updateEditController,
                decoration: const InputDecoration(hintText: 'Edit'),
              ),
            ),
          );
        });
  }
}


// ListTile(

                        //   leading: Image.network(st),
                        //   title: Text(snapshot.data!.docs[index]['Address'].toString()),
                        //   subtitle:Text(snapshot.data!.docs[index]['pincode'].toString()),
                        //   trailing: PopupMenuButton(
                        //         child: Icon(Icons.more_vert),
                        //         itemBuilder: (context)=>[
                        //           PopupMenuItem(

                        //             value: 1,
                        //             child: ListTile(

                        //               onTap: (){
                        //                 Navigator.pop(context);
                        //                 showMyDialogBox(title,snapshot.data!.docs[index]['id'].toString());
                        //               },
                        //               trailing: Icon(Icons.edit),
                        //               title: Text('Edit'),

                        //           )),
                        //           PopupMenuItem(
                        //             value: 2,
                        //             child: ListTile(
                        //               onTap: (){
                        //                 Navigator.pop(context);
                        //                 ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                        //               },
                        //               trailing: Icon(Icons.delete),
                        //               title: Text('Delete'),

                        //           )),
                        //         ]
                        //         ),

                        // );
