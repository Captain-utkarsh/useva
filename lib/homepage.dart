//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:useva/auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/avd.dart';
//import 'package:useva/navigation_bloc.dart';
//import 'package:useva/sidebar.dart';
import 'package:useva/sidebar/collapsing_navigation_drawer_widget.dart';
//import 'package:useva/sidebar_layout.dart';
import 'auth_provider.dart';
import 'dart:io';



class HomePage extends StatefulWidget {
  final VoidCallback onSignedOut;

  const HomePage({Key key, this.onSignedOut}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _HomePageState();
  }

}
 class _HomePageState extends State<HomePage>
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[200],
        title: Text('SEVA USER'),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: WillPopScope(
        //onWillPop: onWillPop,
        child: Stack(
          children: <Widget>[
            Container(
              child: FutureBuilder(
                future: getDataFunction(),
                builder: (_,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                    {

                    }
                  else
                    {
                      return Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.indigoAccent[200],
                          //image: new DecorationImage(image: new AssetImage('assets/images/profile.png'),fit: BoxFit.fitWidth)
                        ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 100,),
                               CircleAvatar(backgroundImage: AssetImage('assets/images/profile.png'),radius: 75,),
                              SizedBox(height: 50,),

                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.indigoAccent[200],
                                  ),
                                  height: 250,
                                  width: 300,
                                    child: Center(child: Column(children: <Widget>[
                                      SizedBox(height: 20,),
                                      Container(
                                        decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          //color: Colors.green[400]
                                        ),

                                        child: Text(
                                         'Name: ' +  snapshot.data['name'],
                                            style: TextStyle(fontSize: 20)
                                        ),
                                      ),
                                      Divider(thickness: 4,color: Colors.black,),
                                      SizedBox(height: 20,),
                                      Text('Blood group:  '+ snapshot.data['Blood group'],style: TextStyle(fontSize: 20),),
                                      Divider(thickness: 4,color: Colors.black,),

                                      SizedBox(height: 20,),
                                      Text('City: ' + snapshot.data['City'],style: TextStyle(fontSize: 20),),
                                      Divider(thickness: 4,color: Colors.black,),

                                      SizedBox(height: 20,),
                                      Center(
                                        child: Text('Mobile number: ' + snapshot.data['Mobile number'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ])),
                              ),
                      ),
                            ],
                          ),
                      );
                    }
                },
            ),
            ),
            CollapsingNavigationDrawer(),
          ],
        ),
      ),
    );
  }
  Future  getDataFunction() async {
    FirebaseUser f1 = await FirebaseAuth.instance.currentUser();
    String uid = f1.uid;

      DocumentSnapshot d1= await Firestore.instance.collection("collection").document(uid).get();
      return d1;
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

}
Future<bool> onWillPop(BuildContext context) async {
//     DateTime now = DateTime.now();
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime) > Duration(seconds: 3)) {
//       currentBackPressTime = now;
//       Toast.show("Press back again to exit" , context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.white,textColor: Colors.black);
//       return false;
//     }
//     return true;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              exit(0);
            },
          )
        ],
      );
    },
  ) ?? false;
}
//child: Text(snapshot.data['name']),