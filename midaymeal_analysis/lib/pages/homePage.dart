import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'loginTeacher.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
var items=[];
  TextEditingController _StudentCount = new TextEditingController();
  TextEditingController _MealCount = new TextEditingController();
  TextEditingController _MenuItemCount = new TextEditingController();
FirebaseMessaging _firebaseMessaging =new FirebaseMessaging();


@override
void initState() {
    // TODO: implement initState
    super.initState();
    pushNotification();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
      title: new Text("Meal Analysis",style: new TextStyle(color: Colors.white),),
       centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.power_settings_new,color: Colors.white,), onPressed: (){
            redirectLogin();
          }),
        ],
      ),
      body:  ListView(
        children: <Widget>[
         Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/9),
                    child: new Text("Total NO. of Students presents :",style: new TextStyle(fontSize: 15,fontWeight: FontWeight.w800),),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 40,right: 40,top: 5),
                        child: new TextField(
                          controller: _StudentCount,
                          decoration: InputDecoration(
                            hintText: "Enter No. of present student here",
                            focusedBorder: OutlineInputBorder(
                              borderRadius:  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color:Colors.grey),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/9),
                    child: new Text("Consumed Meals :",style: new TextStyle(fontSize: 15,fontWeight: FontWeight.w800),),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 40,right: 40,top: 5),
                        child: new TextField(
                          controller: _MealCount,
                          decoration: InputDecoration(
                            hintText: "Enter Consumed Meals here",
                            focusedBorder: OutlineInputBorder(
                              borderRadius:  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color:Colors.grey),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
           new Padding(padding: EdgeInsets.only(top: 5,left: 40,right: 40),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Padding(
                 padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/21),
                 child: new Text("Add menu item:",style: new TextStyle(fontSize: 15,fontWeight: FontWeight.w800),),
               ),
               new Row(
                 children: <Widget>[
                   new Expanded(
                       child: new TextField(
                         controller: _MenuItemCount,
                         decoration: InputDecoration(
                           hintText: "Menu item",
                           focusedBorder: OutlineInputBorder(
                             borderRadius:  BorderRadius.all(Radius.circular(12.0)),
                             borderSide: BorderSide(color:Colors.grey),
                           ),
                           errorBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(12.0)),
                             borderSide: BorderSide(color: Colors.red, width: 2),
                           ),
                         ),
                   )),
                   new Expanded(child: new IconButton(icon: Icon(Icons.add), onPressed:(){
                     addtTOMenuITems();
                   }))
                 ],
               ),
             ],
           ),
           ),
            Padding(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/5),
              child: Container(
                child: new ListView.builder
                  (
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: new Text(items[index],style: new TextStyle(fontSize: 16),),
                      );
                    }
                ),
              ),
            ),


          ],
        ),]
      ),
      bottomSheet:   Container(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.only(top:80.0,bottom: 20.0,left: 130.0,right:40.0),
            child: new RaisedButton(
              onPressed: (){
                validateAndUpload();

              },
              child: new Text("Submit",style: new TextStyle(color: Colors.white),),
              color: Colors.blueAccent,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blueAccent)
              ),
            ),
          ),



      ),
    );
  }

void validateAndUpload() async {

  String url = 'http://shailendraweb.com/MidDay/adddata.php';
  Map<String, String> headers = {
    "Content-type": "application/x-www-form-urlencoded"
  };
  http.Response response = await http.post(
      url, headers: headers, body: {
    "date": "${DateTime.now().toUtc()}",
    "TeacherName":"Shailendra Mewada",
    "Menu":"$items",
    "NoOfStudents":_StudentCount.text,
  });
  if (response.statusCode == 200) {
    print('Response  ${json.decode(response.body)}.');
    Fluttertoast.showToast(msg: "Succes ${json.decode(response.body)}");
   // Navigator.pop(context);
    _StudentCount.clear();
    _MealCount.clear();
    items.clear();

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }




}


  void redirectLogin(){
    Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>TeacherLogin()));
  }
  void addtTOMenuITems(){
  setState(() {
    items.add("${_MenuItemCount.text}");
    _MenuItemCount.clear();
    print('List $items');
  });
  }
void pushNotification(){
  _firebaseMessaging.getToken().then((onValue){
 print("token is given by the value =======$onValue");
  });
  _firebaseMessaging.configure(
    onLaunch: (Map<String,dynamic> msg )async{

    },
    onResume: (Map<String,dynamic> msg )async{

    },
    onMessage: (Map<String,dynamic> msg )async{

    },
//       onBackgroundMessage: (Map<String,dynamic> msg )async{
//
//       },
  );
}
}
