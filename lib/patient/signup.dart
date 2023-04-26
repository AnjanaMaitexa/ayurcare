import 'dart:convert';

import 'package:ayurvedichospital/Widgets/textformfield.dart';
import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/loginpage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {

  String? gender;

  TextEditingController nameController = TextEditingController();
  TextEditingController  ageController = TextEditingController();
  TextEditingController  genController = TextEditingController();
  TextEditingController  emailController = TextEditingController();
  TextEditingController  phnController = TextEditingController();
  TextEditingController  addController = TextEditingController();
  TextEditingController  placeController = TextEditingController();
  TextEditingController  postController = TextEditingController();
  TextEditingController  pinController = TextEditingController();
  TextEditingController  userController = TextEditingController();
  TextEditingController  pwdController = TextEditingController();
  TextEditingController  cpwdController = TextEditingController();
  List images = ["g.png", "t.png", "f.png"];

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    genController.dispose();
    addController.dispose();
    phnController.dispose();
    emailController.dispose();
    placeController.dispose();
    postController.dispose();
    pinController.dispose();
    userController.dispose();
    pwdController.dispose();
    cpwdController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
bool _isLoading=false;
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "patientusername": userController.text.trim(),
      "patientpassword": pwdController.text.trim(),
      "patientname": nameController.text.trim(),
      "patientage": ageController.text.trim(),
      "patientgender": gender.toString(),
      "patientemail": emailController.text.trim(),
      "patientphone": phnController.text,
      "patientaddress": addController.text,
      "patientplace": placeController.text,
      "patientpost": postController.text,
      "patientpincode": pinController.text,
    };
    print("patient data${data}");
    var res = await Api().authData(data,'/api/patient_register');
    var body = json.decode(res.body);
    print('res${res}');
    if(body['success']==true)
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;



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
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 20,),
                    textContainer("Name",nameController),
                    SizedBox(height: 10,),
                    textContainer("Age",ageController),
                    SizedBox(height: 10,),
                    Text("Gender"),
                    RadioListTile(
                      title: Text("Male"),
                      value: "male",
                      groupValue: gender,
                      onChanged: (value){
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),

                    RadioListTile(
                      title: Text("Female"),
                      value: "female",
                      groupValue: gender,
                      onChanged: (value){
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),

                    RadioListTile(
                      title: Text("Other"),
                      value: "other",
                      groupValue: gender,
                      onChanged: (value){
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),

                    SizedBox(height: 10,),
                    textNumContainer("Phone",phnController),
                    SizedBox(height: 10,),
                    textContainer("Address",addController),
                    SizedBox(height: 10,),
                    textContainer("Place",placeController),
                    SizedBox(height: 10,),
                    textContainer("Post",postController),
                    SizedBox(height: 10,),
                    textNumContainer("Pin",pinController),
                    SizedBox(height: 10,),
                    textEmailContainer("Email",emailController),
                    SizedBox(height: 10,),
                    textContainer("Username",userController),
                    SizedBox(height: 10,),
                    textPwdContainer("Password",pwdController),
                    SizedBox(height: 10,),
                    textPwdContainer("Confirm password",cpwdController),


                  ],
                ),
              ),
            ),
            SizedBox(height: 70,),
            GestureDetector(
              onTap: (){
                registerUser();
              },
              child: Container(
                width: w*0.5,
                height:h*0.08,
                color:  Color(0xFF772F16),
                child: Center(
                  child: Text("SignUp",style:TextStyle(
                      fontSize:36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  )),
                ),
              ),
            ),
            SizedBox(height: w*0.08,),
            RichText(text:TextSpan(
                text:"Already have an account?",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 20
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Navigator.pop(context),
                    text:" SignIn",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),

                  )
                ]
            )),
         /*   Wrap(
              children: List<Widget>.generate(
                  3,(index){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[500],
                    child: CircleAvatar(

                      radius: 25,
                      backgroundImage: AssetImage(
                          "images/"+images[index]
                      ),
                    ),
                  ),
                ) ;
              }
              ),
            )*/
          ],
        ),
      ),

    );
  }
}
