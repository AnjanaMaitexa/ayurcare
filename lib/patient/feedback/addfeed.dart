
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/feedback/viewfeedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFeed extends StatefulWidget {
  const AddFeed({Key? key}) : super(key: key);

  @override
  State<AddFeed> createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
TextEditingController controller=TextEditingController();
  double? _ratingValue;
  late SharedPreferences localStorage;
  late int user_id;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

bool _isLoading=false;
void registerFeed()async {
  localStorage = await SharedPreferences.getInstance();
  user_id = (localStorage.getInt('user_id') ?? 0);
  print('user_id ${user_id}');
  setState(() {
    _isLoading = true;
  });

  var data = {
    "patient": user_id.toString(),
    "feedback": controller.text.trim(),
    "rating": _ratingValue.toString(),
    "date":formattedDate
  };
  print("patient data${data}");
  var res = await Api().authData(data,'api/patientadd_review');
  var body = json.decode(res.body);
  print('res${body}');
  if(res.statusCode == 201) {

    Fluttertoast.showToast(
      msg: body['message'].toString(),
      backgroundColor: Colors.grey,
    );

    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewFeed()));
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

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback",style: TextStyle(color: Color(0xFF8F371B)),),
        backgroundColor: Colors.white ,
        leading:IconButton(onPressed:(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ViewFeed()));
        },
            icon: Icon(Icons.arrow_back,color: Color(0xFF8F371B))),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width:w,
                height:h ,
                child: Card(
                  child:Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text("Rate Your Experience-",style:TextStyle(
                        fontSize:28,
                        fontWeight: FontWeight.w100,
                        ),),
                    SizedBox(height: 20,),
                    Text("Are you Satisfied with the Service?",style:TextStyle(
                      fontSize:20,
                      fontWeight: FontWeight.w500,
                    ),),
                  SizedBox(height: 20,),
                    RatingBar(
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(

                            full: const Icon(Icons.star, color: Colors.orange),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.orange,
                            ),
                            empty: const Icon(
                              Icons.star_outline,
                              color: Colors.orange,
                            )),
                        onRatingUpdate: (value) {
                          setState(() {
                            _ratingValue = value;
                          });
                        }),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width:w,
                    height: 190,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),

                    child: TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Field can't be empty";
                        }
                      },
                      controller: controller,
                      decoration: InputDecoration(
                          hintText:"Tell us on how can we improve..." ,
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


                  SizedBox(height: 30,),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        registerFeed();
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                      },
                      child: Container(
                        width: w*0.5,
                        height:h*0.08,
                        color:  Color(0xFF772F16),
                        child: Center(
                          child: Text("Submit",style:TextStyle(
                              fontSize:36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          )),
                        ),
                      ),
                    ),
                  ),

          ],
        ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
