
import 'package:ayurvedichospital/Widgets/background.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:ayurvedichospital/patient/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailCon = TextEditingController();
  var passCon = TextEditingController();

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
            SizedBox(height: 70,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
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
