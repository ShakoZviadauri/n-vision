import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:n_vision/screens/home.dart';
// import 'package:n_vision/pages/home_page.dart';
import 'package:n_vision/screens/login.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:n_vision/services/localization_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final LocalizationService localizationService = LocalizationService.getInstance();

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: localizationService.init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              supportedLocales: const [
                Locale('en'), // English
                Locale('ru'), // Russian
                Locale('ka'), // Georgian
                // Add more locales as needed
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                ...GlobalCupertinoLocalizations.delegates,
              ],
              locale: localizationService.getLocale(),
              title: 'N Vision',
              debugShowCheckedModeBanner: false,
              home: CheckAuth(),
              darkTheme: ThemeData(brightness: Brightness.dark, hintColor: Colors.blueAccent),
              themeMode: ThemeMode.dark,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

}

class CheckAuth extends StatefulWidget{
  @override
  _CheckAuthState createState() => _CheckAuthState();
}


class _CheckAuthState extends State<CheckAuth>{
  bool isAuth = false;

  @override
  void initState(){
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      if(mounted){
        setState(() {
          isAuth = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context){
    Widget child;
    if(isAuth){
      child = Home();
    } else{
      child = Login();
    }

    return Scaffold(
      body: child,
    );
  }

}