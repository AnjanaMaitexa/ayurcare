
import 'dart:convert';

import 'package:ayurvedichospital/Widgets/background.dart';
import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/doctor/doctorhome.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:ayurvedichospital/patient/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  String user = "patient";
  String doctor = "doctor";

  String storedvalue = "1";
  late SharedPreferences localStorage;
  late int loginId ;
  String role = '';
  String status = '';
  bool _isLoading = false;
  bool _obscureText = true;
  late String  loginid;

  final _formKey = GlobalKey<FormState>();

  _pressLoginButton() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'username': emailCon.text.trim(), //username for email
      'password': passCon.text.trim()
    };
    var res = await Api().authData(data,'api/login_users');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      role = body['data']['role'];
      status =  body['data']['l_status'];


      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('role', role.toString());
      localStorage.setInt('login_id',  body['data']['login_id']);
      localStorage.setInt('user_id',  body['data']['user_id']);

      print('login_id ${body['data']['login_id']}');
      print('user_id ${body['data']['user_id']}');

   /*   if (user == role.replaceAll('"', '') &&
          storedvalue == status.replaceAll('"', '')) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else if (doctor == role.replaceAll('"', '') &&
          storedvalue == status.replaceAll('"', '')) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DoctHome(),
        ));
     }*/
       if (user == role &&
          storedvalue == status) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else if (doctor == role &&
          storedvalue == status) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DoctHome(),
        ));
     }else {
        Fluttertoast.showToast(
          msg: "Please wait for admin approval",
          backgroundColor: Colors.grey,
        );
      }


    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  String _password = "";

  @override
  void dispose() {
    emailCon.dispose();
    passCon.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w,
              height: h*0.3,
              decoration: BoxDecoration(
                  image:DecorationImage(
                      image: AssetImage(
                          "images/la.jpg"
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Container(
              width: w,
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",style: TextStyle(
                      fontSize: 70,
                      color:  Color(0xFF772F16),
                      fontWeight: FontWeight.bold,
                    ),),
                    Text(
                      "SignIn to your account",style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF8F371B),
                    ),),
                    SizedBox(height: 50,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow:[ BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,1),
                              color: Colors.grey.withOpacity(0.2)
                          )]
                      ),
                      child: TextField(
                        controller: emailCon,
                        decoration: InputDecoration(
                            hintText:"Email",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0
                                )
                            ), enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0
                            )
                        ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow:[ BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,1),
                              color: Colors.grey.withOpacity(0.2)
                          )]
                      ),
                      child: TextField(
                        controller: passCon,
                        decoration: InputDecoration(
                            hintText: "Password",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0
                                )
                            ), enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0
                            )
                        ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                 /*   Row(
                      children: [
                        Expanded(child: Container(),),
                        Text(
                          "Forgot your password?",style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF8F371B),
                        ),),

                      ],
                    )*/

                  ],
                ),
              ),
            ),
            SizedBox(height: 70,),
            GestureDetector(
              onTap: (){
              _pressLoginButton();
               // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
              },
              child: Container(
                width: w*0.5,
                height:h*0.08,
               color:  Color(0xFF772F16),
                child: Center(
                  child: Text("SignIn",style:TextStyle(
                      fontSize:36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  )),
                ),
              ),
            ),
            SizedBox(height: w*0.08,),
            RichText(text:TextSpan(
                text:"Don\'t have an account?",
                style: TextStyle(
                    color: Color(0xFF8F371B),
                    fontSize: 20
                ),
                children: [
                  TextSpan(
                      text:" Create",
                      style: TextStyle(
                          color:  Color(0xFF772F16),
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()..onTap=()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp())))


                ]
            ))
          ],
        ),
      ),
    );
  }
}
