import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midaymeal_analysis/pages/homePage.dart';
class TeacherLogin extends StatefulWidget {
  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  TextEditingController _userID=new TextEditingController();
  TextEditingController _Password=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          new Container(
            height: MediaQuery.of(context).size.height/8,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: new Container(
              height: 50,
              width: MediaQuery.of(context).size.width/1.2,
              child: new TextField(
                controller: _userID,
                decoration: InputDecoration(
                  hintText: "Enter User Id",
                  focusedBorder: OutlineInputBorder(
                    borderRadius:  BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  labelText: "Email",
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: new Container(
              height: 50,
              width: MediaQuery.of(context).size.width/1.2,
              child: new TextField(
                controller: _Password,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius:  BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color:Colors.grey),
                  ),
                  labelText: "Password",
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),

            ),
          ),
          new Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/18),
            child: Container(
              width: MediaQuery.of(context).size.width/1.2,
              height: 40,
              child: new RaisedButton(
                onPressed: (){
                  verifyUser();
                  _Password.clear();
                  _userID.clear();
                },
              child: new Text("Login",style: new TextStyle(color: Colors.white),),
                color: Colors.blueAccent,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blueAccent)
                ),
              ),
              

            ),
          )

        ],
      ),
    );
  }
 void verifyUser(){
    if(_userID.text == "" && _Password.text=="" ){
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_)=>HomePage()));
    }
    else{
      Fluttertoast.showToast(
        msg: "Invalid UserID or Password",
        timeInSecForIos: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 15,
      );
    }
 }
}
