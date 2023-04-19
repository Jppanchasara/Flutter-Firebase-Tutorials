

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase/redialButton.dart';
import 'package:firebase/ui/Post/add_postScreen.dart';
import 'package:firebase/ui/Post/post_screen.dart';
import 'package:firebase/ui/auth/login_Screen.dart';
import 'package:firebase/ui/firestore_Database/firestore_Add_Post_Screen.dart';
import 'package:firebase/ui/firestore_Database/firestore_list_screen.dart';
import 'package:firebase/ui/image_upload.dart';
import 'package:firebase/ui/utills/utills.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ConvexAppExample extends StatefulWidget {
  const ConvexAppExample({super.key});

  @override
  _ConvexAppExampleState createState() => _ConvexAppExampleState();
}

class _ConvexAppExampleState extends State<ConvexAppExample> {
    final auth = FirebaseAuth.instance;
    bool loading=false;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore post screen'),
        backgroundColor: Colors.purple,
        centerTitle: false,
        
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
          const SizedBox(
            width: 20,
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  [
            // DrawerHeader(child: Text('Profile')),
           const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff764abc),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage:  NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
              ),
                accountName: Text('PANCHASARA JAYESH'),
                accountEmail: Text('panchasrajayesh@gmail.com')),
            ListTile(
              leading:const Icon(Icons.home),
              title: const Text('page 1'),
              onTap: () { 
              },
            ),
            ListTile(
              leading: const Icon(Icons.cast_for_education),
              title: const Text('page 1'),
              onTap: () { 

              },
            ),
            ListTile(
              leading:const Icon(Icons.calculate),
              title:const Text('page 1'),
              onTap: () { 
              },
            ),
            ListTile(
              leading:const Icon(Icons.phone),
              title:const Text('page 1'),
              onTap: () { 
              },
            ),
            
            const SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RoundButton(title: 'Log out',loading: loading, onPress: (){
                setState(() {
                   loading=true;
                });
                auth.signOut().then((value) {
                  setState(() {
                    loading=false;
                  });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading=false;
                    });
                    utills().TosterMessage(error.toString());
                  });
            
              }),
            )
          ],
        ),
      ),
      
      
     
      
       body: DefaultTabController(
        length: 4,
        initialIndex: 2,
        child: Scaffold(
          body: Column(
            children:const  [
              const Divider(),
              Expanded(
                child: TabBarView(
                  
                  children: [
                    
                    FireStoreListScreen(),
                    FirestoreAddPostScreen(),
                  
                    FireStoreListScreen(),
                    ReadialButtonScreen(),
                    

                    
                    
                    
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: Colors.purple.shade400,
            color: Colors.white,
            activeColor: Color.fromARGB(255, 189, 141, 197),
            
          
            
             //const <int, dynamic>{2: '99+'},
            style: TabStyle.reactCircle,
            items:const [
              
              TabItem(icon: Icon(Icons.home,color: Colors.white),title: 'Home'),
              TabItem(icon: Icon(Icons.add,color: Colors.white,),title: 'Add'),
              TabItem(icon: Icon(Icons.image,color: Colors.white),title: 'image'),
              TabItem(icon: Icon(Icons.circle,color: Colors.white),title: 'Radial'),
              
              
              
              
              
            ],
            onTap: (int i){
            },
          ),
        ),
      ),
    );
  }

}
