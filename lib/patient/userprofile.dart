
import 'package:ayurvedichospital/Widgets/textformfield.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {


  TextEditingController nameController = TextEditingController();
  TextEditingController  ageController = TextEditingController();
  TextEditingController  genController = TextEditingController();
  TextEditingController  emailController = TextEditingController();
  TextEditingController  phnController = TextEditingController();
  TextEditingController  addController = TextEditingController();
  TextEditingController  placeController = TextEditingController();
  TextEditingController  postController = TextEditingController();
  TextEditingController  pinController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
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

    );
  }
}
