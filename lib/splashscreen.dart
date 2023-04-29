
import 'dart:async';

import 'package:ayurvedichospital/doctor/dochomepage.dart';
import 'package:ayurvedichospital/loginpage.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String user = "patient";
  String doctor = "doctor";

  String storedvalue = "1";
   String role="";
  late SharedPreferences localStorage;


  Future<void> checkRoleAndNavigate() async {
    localStorage = await SharedPreferences.getInstance();
    role = (localStorage.getString('role') ?? '');
    print(role);
    if (user == role) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else if (doctor == role) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DoHomePage(),
      ));
    }  else  {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
    }
  }


  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 4);
    return Timer(duration, checkRoleAndNavigate);
  }
/*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => LoginPage()
            )
        )
    );
  }*/
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:30.0),
                child: Image.asset("images/logoPNG.png"),
              ),

            ]
        ),
      ),
    );
  }
}
