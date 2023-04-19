import 'package:firebase/ui/Post/add_postScreen.dart';
import 'package:firebase/ui/auth/login_Screen.dart';
import 'package:firebase/ui/utills/utills.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFillter =TextEditingController();
  final updateEditController =TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.purple,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 10,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }).onError((error, stackTrace) {
                  utills().TosterMessage(error.toString());
                });
              },
              icon: const Icon(Icons.login_rounded)),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchFillter,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
      
              ),
              onChanged: (String value){
                setState(() {
                  
                });

              },
            ),
            Expanded(
              child: FirebaseAnimatedList(
                defaultChild: Center(child: Text('Loading....',style: TextStyle(fontSize: 25,color: Colors.black26),)),
                query: ref,
                itemBuilder: (context,snapshot,animation,index){
                  final title =snapshot.child('Address').value.toString();
                  if(searchFillter.text.isEmpty){
                    return ListTile(
                          title:Text(snapshot.child('Address').value.toString(),style: TextStyle(fontWeight: FontWeight.w500),) ,
                          subtitle: Text(snapshot.child('pincode').value.toString()),
                          //subtitle: Text(snapshot.child('id').value.toString()),
                          
                          trailing: PopupMenuButton(
                            child: Icon(Icons.more_vert),
                            itemBuilder: (context)=>[
                              PopupMenuItem(
                                
                                value: 1,
                                child: ListTile(
                                  
                                  onTap: (){
                                    Navigator.pop(context);
                                    showMyDialogBox(title,snapshot.child('id').value.toString());
                                  },
                                  trailing: Icon(Icons.edit),
                                  title: Text('Edit'),
                                  
                              )),
                              PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    ref.child(snapshot.child('id').value.toString()).remove();
                                  },
                                  trailing: Icon(Icons.delete),
                                  title: Text('Delete'),
                                  
                              )),
                            ]
                            ),
        
                        
                    );

                  }else if(title.toLowerCase().contains(searchFillter.text.toLowerCase().toLowerCase())){
                      return ListTile(
                          title:Text(snapshot.child('Address').value.toString(),style: TextStyle(fontWeight: FontWeight.w500),) ,
                          trailing:Text(snapshot.child('time').value.toString()) ,
                          subtitle: Text(snapshot.child('pincode').value.toString()),
        
                        );
                  }
                  else{
                     return  Container();

                  }


                  // return Column(
                  //   children: [
                  //     ListTile(
                  //       title:Text(snapshot.child('Address').value.toString(),style: TextStyle(fontWeight: FontWeight.w500),) ,
                  //       trailing:Text(snapshot.child('time').value.toString()) ,
                  //       subtitle: Text(snapshot.child('pincode').value.toString()),
      
                  //     ),
                      
                  //   ],
                  // );
                }
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }


  Future<void> showMyDialogBox(String title,String id)async{
    updateEditController.text=title;
    return showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Update'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel')),
            TextButton(onPressed: (){
              Navigator.pop(context);
              ref.child(id).update({
                'Address':updateEditController.text.toLowerCase()

              }).then((value) {
                utills().TosterMessage('Post Updated');

              }).onError((error, stackTrace) {
                utills().TosterMessage(error.toString());

              });


            }, child: Text('Update'))
          ],
          content: Container(
            child: TextFormField(
              controller: updateEditController,
              decoration: InputDecoration(
                hintText: 'Edit'
              ),

            ),
            
            
          ),

        );
      }
      );

  }

}
