import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:n_vision/network/api.dart';
import 'package:n_vision/screens/register.dart';
import 'package:n_vision/screens/home.dart';

// import 'package:n_vision/pages/home_page.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;
  
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


  void showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  void _showMsg(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: HexColor('f2f6ff'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 72),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              const SizedBox(height: 100,),

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
                    // left: 500 / 2, 
                    // right: 500 / 2,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromARGB(19, 0, 0, 0),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Welcome Back",
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
                                  "Enter your credentials to access your account",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    height: 1,
                                    color: HexColor('bfc3ce'),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "NotoSans-Regular",
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                  TextFormField(
                                    cursorColor: HexColor('54647f'),
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      // fillColor: Colors.red,
                                      hintText: "Enter your email",
                                      hintStyle: TextStyle(
                                        color: HexColor('A0A3A7'),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "NotoSans-Regular",
                                      ),
                                      iconColor: Colors.green,
                                      suffixIcon: const Icon(Icons.email),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Color.fromARGB(19, 0, 0, 0), width: 1.0),
                                      ),
                                    ),
                                    validator: (emailValue) {
                                      if (emailValue == null || emailValue.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      email = emailValue;
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  TextFormField(
                                    cursorColor: Colors.blue,
                                    keyboardType: TextInputType.text,
                                    obscureText: _secureText,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.blue)
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Color.fromARGB(19, 0, 0, 0), width: 1.0),
                                      ),

                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                        color: HexColor('A0A3A7'),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "NotoSans-Regular",
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: showHide,
                                        icon: Icon(_secureText
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                      ),
                                    ),
                                    validator: (passwordValue) {
                                      if (passwordValue == null ||
                                          passwordValue.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      password = passwordValue;
                                      return null;
                                    },
                                  ),
                              ],
                            ),
                          ),
                          


                          const SizedBox(height: 12),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              // primary: Colors.blueAccent,
                              // onPrimary: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 25),
                            ),
                            onPressed: _isLoading ? null : _handleLogin,
                            child: Text(
                              _isLoading ? 'Processing...' : 'Login'.toUpperCase(),
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

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      'Register',
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

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      var data = {'email': email, 'password': password};

      try {
        var res = await Network().auth(data, '/login');
        var body = json.decode(res.body);

        if (body['success']) {
          SharedPreferences localStorage = await SharedPreferences.getInstance();
          localStorage.setString('token', json.encode(body['token']));
          localStorage.setString('user', json.encode(body['user']));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          _showMsg(body['message']);
        }
      } catch (e) {
        _showMsg("An error occurred: $e");
      }

      setState(() {
        _isLoading = false;
      });
    }
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
