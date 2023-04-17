import 'package:ayurvedichospital/Widgets/textformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
                    textContainer("Password",pwdController),
                    SizedBox(height: 10,),
                    textContainer("Confirm password",cpwdController),


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
