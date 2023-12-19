import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n_vision/network/api.dart';
import 'dart:convert';
import 'login.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  String name='';

  @override
  void initState(){
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userString = localStorage.getString('user');

    if (userString != null) {
      var user = jsonDecode(userString);

      if (user != null && user is Map<String, dynamic>) {
        setState(() {
          name = user['name'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff151515),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xff151515),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: (){
              logout();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Hello, ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text('${name}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void logout() async{
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context)=>Login()
          )
      );
    }else{
      print('error');
    }
  }
}