import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
DocumentSnapshot snapshot;
QuerySnapshot querySnapshot, querySnapshot1;
String city;

class showevent extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return showeventstate();

  }

}
class showeventstate extends State<showevent>
{
  RandomColor color=RandomColor();
  bool value=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  Future<void> getdata() async{

    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    String uid=user.uid;
    snapshot=await Firestore.instance.collection('collection').document(uid).get();
    setState(() {
      city=snapshot.data['City'];
      city=city.toLowerCase();
    });
    Firestore.instance.collection('events').where('City',isEqualTo: city).getDocuments().then((result){
      setState(() {
        querySnapshot=result;
        value=true;
      });
    });

    print(city);

    print(querySnapshot1.documents[0].data['Description']);
    setState(() {

      print(value);
    });
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: value==false ? CircularProgressIndicator() :
      Container(
        padding: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50,),
              Text("Events",
                style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
              ListView.separated(itemCount: querySnapshot.documents.length,
                  shrinkWrap: true,
                  separatorBuilder: (context,index)=>SizedBox(height: 10,),
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new Card(
                      borderOnForeground: true,
                      elevation: 20.0,

                      color: color.randomColor(colorBrightness: ColorBrightness.light),
                      child:Container(
                        padding: EdgeInsets.all(25),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[
                            Text("Venue:- "+querySnapshot.documents[index].data['Hospital name']+","+querySnapshot.documents[index].data['City'],style: TextStyle(fontFamily: "R",fontSize: 18)),
                            Text("Description:- "+querySnapshot.documents[index].data['Description'],style: TextStyle(fontFamily: "R",fontSize: 18)),
                            Text("Date:- "+querySnapshot.documents[index].data['Date'],style: TextStyle(fontFamily: "R",fontSize: 18)),
                          ],
                        ),
                      )
                    );
                  }),
            ],
          ),
        ),
      )
    );
  }

}