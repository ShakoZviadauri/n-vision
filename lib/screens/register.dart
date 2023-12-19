import 'dart:async';

import 'package:flutter/material.dart';
import 'login.dart';
import 'package:n_vision/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'home.dart';

class Register extends StatefulWidget{
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>{
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;
  late String name, email, password;



  int _colorIndex = 0;
  final List<Color> _colors = [
    HexColor('46dee2'), // Replace these with your custom colors
    HexColor('ebb13c'),
    HexColor('a54cce'),
    HexColor('497f9c'),
    HexColor('f26b8b'),
    HexColor('71c6b7'),
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _colorIndex = (_colorIndex + 1) % _colors.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  showHide(){
    setState(() {
      _secureText = !_secureText;
    });
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: HexColor('f2f6ff'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 72),
          child: Column(
            children: [

              const SizedBox(height: 80,),

              Image.asset(
                'assets/images/test_logo1.webp',
                width: 200,
              ),

              const SizedBox(height: 20,),

              Center(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Text(
                    'n Vision.',
                    style: TextStyle(
                      color: _colors[_colorIndex],
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Pacifico-Regular",
                    ),
                  ),
                ),
              ),


              Container(
                width: 600,
                child: Card(
                  elevation: 0,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 60, 
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromARGB(19, 0, 0, 0),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create Your Account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 2,
                              color: HexColor('3a5675'),
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              fontFamily: "NotoSans-Regular",
                            ),
                          ),

                          Text(
                            "Welcome back, Please enter your details",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1,
                              color: HexColor('bfc3ce'),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: "NotoSans-Regular",
                            ),
                          ),

                          const SizedBox(height: 50),
                          
                          TextFormField(
                            cursorColor: HexColor('54647f'),
                            keyboardType: TextInputType.name,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              // fillColor: Colors.red,
                              hintText: "Full name",
                              hintStyle: TextStyle(
                                color: HexColor('A0A3A7'),
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: "NotoSans-Regular",
                              ),
                              iconColor: Colors.green,
                              suffixIcon: const Icon(Icons.face_5),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(19, 0, 0, 0), width: 1.0),
                              ),
                            ),
                            validator: (nameValue){
                              if(nameValue!.isEmpty){
                                return 'Please enter your full name';
                              }
                              name = nameValue;
                              return null;
                            }
                          ),
                          
                          const SizedBox(height: 12),

                          TextFormField(
                            cursorColor: Colors.blue,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Email",
                              suffixIcon: const Icon(Icons.email),
                              hintStyle: TextStyle(
                                color: HexColor('A0A3A7'),
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: "NotoSans-Regular",
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(19, 0, 0, 0), width: 1.0),
                              ),
                            ),
                            validator: (emailValue){
                              if(emailValue!.isEmpty){
                                return 'Please enter your email';
                              }
                              email = emailValue;
                              return null;
                            }
                          ),
                          
                          const SizedBox(height: 12),

                          TextFormField(
                            cursorColor: Colors.blue,
                            keyboardType: TextInputType.text,
                            obscureText: _secureText,
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: HexColor('A0A3A7'),
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: "NotoSans-Regular",
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(19, 0, 0, 0), width: 1.0),
                              ),
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            validator: (passwordValue){
                              if(passwordValue!.isEmpty){
                                return 'Please enter your password';
                              }
                              password = passwordValue;
                              return null;
                            }
                          ),
                          
                          const SizedBox(height: 30),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              // primary: Colors.blueAccent,
                              // onPrimary: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 25),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _register();
                              }
                            },
                            child: Text(
                              _isLoading ? 'Processing..' : 'Register',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                height: 1,
                                color: HexColor('ffffff'),
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: "NotoSans-Regular",
                              ),
                            ),
                          ),

                          const SizedBox(height: 13),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      height: 1,
                      color: HexColor('000000'),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: "NotoSans-Regular",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(
                          context,
                          new MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        height: 1,
                        color: HexColor('000000'),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "NotoSans-Regular",
                      ),
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

  void _register() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name' : name,
      'email' : email,
      'password' : password
    };

    var res = await Network().auth(data, '/register');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home(),
          ),
      );
    }else{
      if(body['message']['name'] != null){
        _showMsg(body['message']['name'][0].toString());
      }
      else if(body['message']['email'] != null){
        _showMsg(body['message']['email'][0].toString());
      }
      else if(body['message']['password'] != null){
        _showMsg(body['message']['password'][0].toString());
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}