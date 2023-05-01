
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/complaints/add_complaints.dart';
import 'package:ayurvedichospital/patient/feedback/addfeed.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewFeed extends StatefulWidget {
  const ViewFeed({Key? key}) : super(key: key);

  @override
  State<ViewFeed> createState() => _ViewFeedState();
}

class _ViewFeedState extends State<ViewFeed> {
  List feedback = [];
  bool isLoading = false;
  late SharedPreferences localStorage;
  late int user_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchDisease();
  }

  _fetchDisease() async {
    localStorage = await SharedPreferences.getInstance();
  user_id = (localStorage.getInt('user_id') ?? 0);
    var res = await Api()
        .getData('api/patient_all_review');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        feedback = items;

      });
    } else {
      setState(() {
        feedback = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF5DCEEFD) ,
      appBar: AppBar(
        title: Text("Feedback",style: TextStyle(color: Color(0xFF8F371B)),),
        backgroundColor: Colors.white ,
        leading:IconButton(onPressed:(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
        },
            icon: Icon(Icons.arrow_back,color: Color(0xFF8F371B))),
      ),
      body: Container(

        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
              children:<Widget> [

                Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Text("Feedback",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8F371B)
                  ),),
                ),
                SizedBox(height:20),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap:true,
                  itemCount: feedback.length,
                  itemBuilder: (context,index){
                    return Card(
                        child:Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                       Text("Feedback: "+feedback[index]['feedback']),
                                        SizedBox(height: 10,),
                                        RatingBar(
                                          initialRating: 3,
                                          itemCount:(double.parse(feedback[index]['rating']).toInt()) ,
                                          itemSize: 20,
                                          allowHalfRating: true,
                                          ratingWidget: RatingWidget(
                                            full: Icon(Icons.star, color: Colors.amber),
                                            half: Icon(Icons.star_half, color: Colors.amber),
                                            empty: Icon(Icons.star_border, color: Colors.amber),
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        SizedBox(height: 10,),
                                        Text("Date: "+feedback[index]['date']),
                                      ],
                                    ),


                                  ),

                                ],
                              ),
                            ],
                          ),
                        )


                    );
                  },
                )
              ]),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddFeed(),
          ));
        },
        tooltip: 'Add Complaints',
        child: const Icon(Icons.add),
      ),
    );
  }
}
