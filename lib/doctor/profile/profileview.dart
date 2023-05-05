
import 'dart:convert';

import 'package:ayurvedichospital/Widgets/textformfield.dart';
import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/doctor/dochomepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController  qualification = TextEditingController();
  TextEditingController  specController = TextEditingController();
  TextEditingController  emailController = TextEditingController();
  TextEditingController  phnController = TextEditingController();
  TextEditingController  daysController = TextEditingController();
  TextEditingController  expController = TextEditingController();
  late int doctor_id;
  String name = "";
  String experience = "";
  String phn = "";
  String quali = "";
  String special = "";
  String email = "";
  String dayss = "";
  String image="";

  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    doctor_id = (prefs.getInt('user_id') ?? 0 );
    print('login_idupdate ${doctor_id}');
    var res = await Api()
        .getData('api/single_doctor/' + doctor_id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['doctorname'];
      experience = body['data']['doctorexperience'];
      quali = body['data']['doctorqualification'];
      special = body['data']['doctorspecialization'];
      dayss = body['data']['doctor_available_days'];
      phn = body['data']['doctorphone'];
      email = body['data']['doctoremail'];
      image =body['data']['doctorprofile_photo'];

      nameController.text = name;
      qualification.text=quali;
      expController.text=experience;
      emailController.text = email;
      phnController.text = phn;
      specController.text = special;
      daysController.text=dayss;

    });
  }
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Management",style: TextStyle(color: Color(0xFF8F371B)),),
        backgroundColor: Colors.white ,
        leading:IconButton(onPressed:(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DoHomePage()));
        },
            icon: Icon(Icons.arrow_back,color: Color(0xFF8F371B))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: w,
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 20,),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      color:Color(0xFF8F371B) ,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.lightBlueAccent,
                              radius: 50,
                              backgroundImage:NetworkImage("http://127.0.0.1:8000"+image) ,),
                            SizedBox(
                              width: 10,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(name, style:TextStyle(
                                      fontSize: 23,color: Colors.white
                                  ) ,),
                                  Text(quali, style:TextStyle(
                                      fontSize: 18,color: Colors.white
                                  ) ,),
                                  Text(special, style:TextStyle(
                                      fontSize: 18,color: Colors.white
                                  ) ,)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Experience',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: expController,
                      readOnly: true,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Complaint'),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      readOnly: true,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Description'),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'PhoneNumber',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: phnController,
                      readOnly: true,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Location'),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Allocated Days',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: daysController,
                      readOnly: true,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Location'),
                    ),


                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
