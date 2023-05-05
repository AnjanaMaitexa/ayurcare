
import 'dart:convert';

import 'package:ayurvedichospital/Widgets/textformfield.dart';
import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoProfile extends StatefulWidget {
  const DoProfile({Key? key}) : super(key: key);

  @override
  State<DoProfile> createState() => _DoProfileState();
}

class _DoProfileState extends State<DoProfile> {


  TextEditingController nameController = TextEditingController();
  TextEditingController  ageController = TextEditingController();
  TextEditingController  genController = TextEditingController();
  TextEditingController  emailController = TextEditingController();
  TextEditingController  phnController = TextEditingController();
  TextEditingController  addController = TextEditingController();
  TextEditingController  placeController = TextEditingController();
  TextEditingController  postController = TextEditingController();
  TextEditingController  pinController = TextEditingController();

  late int user_id;
  String name = "";
  String address = "";
  String phn = "";
  String age = "";
  String gender = "";
  String email = "";
  String place = "";
  String post = "";
  String pin = "";
  late SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();
  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    print('login_idupdate ${user_id}');
    var res = await Api()
        .getData('api/single_patient/' + user_id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['patientname'];
      age = body['data']['patientage'];
      gender = body['data']['patientgender'];
      address = body['data']['patientaddress'];
      place = body['data']['patientplace'];
      post = body['data']['patientpost'];
      phn = body['data']['patientphone'];
      email = body['data']['patientemail'];
      pin = body['data']['patientpincode'];

      nameController.text = name;
      ageController.text=age;
      genController.text=gender;
      emailController.text = email;
      phnController.text = phn;
      addController.text = address;
      placeController.text=place;
      postController.text=post;
      pinController.text=pin;

    });
  }
  _update() async {
    setState(() {
      var _isLoading = true;
    });

    var data = {
      "patientname": nameController.text,
      "patientaddress": addController.text,
      "patientemail": emailController.text,
      "patientage": ageController.text,
      "patientgender":gender.toString(),
      "patientphone": phnController.text,
      "patientplace": placeController.text,
      "patientpost": postController.text,
      "patientpincode": pinController.text,
    };
    print(data);
    var res = await Api().putData(data, 'api/update_patient/'+user_id.toString());
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:Colors.transparent,
        appBar: AppBar(
            backgroundColor:Colors.white,
            title: Text("My Profile",style: TextStyle(color: Color(0xFF8F371B)),),
       leading: IconButton(onPressed: (){
         Navigator.pop(context);
       }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

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


                    ],
                  ),
                ),
              ),
              SizedBox(height: 70,),
              GestureDetector(
                onTap: (){
                  _update();
                },
                child: Container(
                  width: w*0.5,
                  height:h*0.08,
                  color:  Color(0xFF772F16),
                  child: Center(
                    child: Text("Update",style:TextStyle(
                        fontSize:36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    )),
                  ),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
