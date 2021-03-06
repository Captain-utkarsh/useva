import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:useva/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:useva/homepage.dart';
import 'package:useva/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'FadeAnimation.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key key, this.onSignedIn});
  final VoidCallback onSignedIn;


  @override
  LoginPageState createState() => new LoginPageState();
}
class LoginPageState extends State<LoginPage>
{

  String email,password;
  final GlobalKey<FormState> formkey=GlobalKey<FormState>();

  Future<bool> onWillPop() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        body: WillPopScope(
          onWillPop: onWillPop,
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeAnimation(1.2, Text("Login",
                  style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
                SizedBox(height: 30,),
                FadeAnimation(1.5, Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  child: Form(
                    key: formkey,
                    child:Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[300]))
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Email or Phone number"
                            ),
                            validator:(input) {
                              if(input.isEmpty){
                                return "Please type email";
                              }
                            },
                            onChanged: (input) => email=input ,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                          ),
                          child: TextFormField(


                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                hintText: "Password"
                            ),
                            obscureText: true,
                            validator:(input) {
                              if(input.isEmpty){
                                return 'Please type password';
                              }
                            },
                            onChanged: (input) => password=input ,
                          ),
                        ),

                      ],
                    ),
                  ),
                )),
                SizedBox(height: 40,),
                FadeAnimation(1.8, Center(
                  child: Container(
                    width: 130,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue[800]
                    ),
                    child: Center(child: FlatButton(child:Text("Login", style: TextStyle(color: Colors.white.withOpacity(.7)),),
                      onPressed: (){signIn();print(email);print(password);},

                    )),
                  ),
                )),
                FadeAnimation(1.8, Center(
                    child: Container(
                      width: 190,
                      padding: EdgeInsets.all(10),
                      child: Center(child: FlatButton(child:Text("Create New Account", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                        onPressed: ()
                        {
                          Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: signup()));
                        },),
                      ),
                    ))),
              ],
            ),
          ),
        )
    );

  }
  Future<void> signIn() async
  {
    final formState=formkey.currentState;
    if(formState.validate())
    {
      formState.save();
      try {
        final user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: email, password: password) ;
        print(user);
        widget.onSignedIn();
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }catch(e){
        print(e.message);

      }
    }
  }
}
