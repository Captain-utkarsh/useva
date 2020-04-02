import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:useva/auth.dart';
import 'package:useva/navigation_bloc.dart';
import 'auth_provider.dart';




class HomePage extends StatefulWidget  {
  final VoidCallback onSignedOut;

  const HomePage({Key key, this.onSignedOut}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _HomePageState();
  }

}
 class _HomePageState extends State<HomePage> with NavigationStates
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('SEVA'),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: Container(
        child: Text("Hello"),
      ),
    );

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
