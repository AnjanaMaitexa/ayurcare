
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/doctor/dochomepage.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewAppoints extends StatefulWidget {
  const ViewAppoints({Key? key}) : super(key: key);

  @override
  State<ViewAppoints> createState() => _ViewAppointsState();
}

class _ViewAppointsState extends State<ViewAppoints> {
  List appoints=[];
  late int user_id;
  late int doc_id;
  String name='';
  String app_time='';
  String bookingnum='';
  String appointment_date='';
  String depart='';
  late SharedPreferences localStorage;

  _fetchData() async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getInt('user_id') ?? 0);

    var res = await Api()
        .getData('api/doctor_token_booking/'+user_id.toString());
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        appoints = items;
        print("appoints${appoints}");

      });
    } else {
      setState(() {
        appoints = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Appointments"),
        backgroundColor:  Color(0xFF8F371B),
        leading:IconButton(onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DoHomePage(),
          ));
        },
            icon: Icon(Icons.arrow_back)),
      ),
      body:Container(
        child: Column(
            children:<Widget> [

              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text("Appointments",style: TextStyle(
                    fontSize:26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8F371B)
                ),),
              ),
              SizedBox(height:20),
              ListView.builder(
                shrinkWrap:true,
                itemCount: appoints.length,
                itemBuilder: (context,index){

                  doc_id=appoints[index]['doctor_id'];

                  //    _viewPro();

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("DoctorId: "+appoints[index]['doctor_id'].toString(),
                            style:TextStyle(
                              fontSize: 18,
                            ) ,),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("Booking Date: "+appoints[index]['appointment_date'],
                                style:TextStyle(
                                  fontSize: 18,
                                ) ,),
                              SizedBox(width: 35,),
                              Text("Booking Time: "+appoints[index]['appointment_time'],
                                style:TextStyle(
                                  fontSize: 18,
                                ) ,),
                            ],
                          ),
                          Text("Token No: "+appoints[index]['number'].toString(),
                            style:TextStyle(
                              fontSize: 18,
                            ) ,),

                        ],
                      ),
                    ),
                  );
                },
              )
            ]),

      ),
    );
  }
}
