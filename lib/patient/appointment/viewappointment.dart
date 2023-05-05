
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/doctors/addappointment.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:ayurvedichospital/patient/model/appoint.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewAppointment extends StatefulWidget {
  const ViewAppointment({Key? key}) : super(key: key);

  @override
  State<ViewAppointment> createState() => _ViewAppointmentState();
}

class _ViewAppointmentState extends State<ViewAppointment> {
/*
  static List<String>depart=['Cardiology','ENT','Orthopaedics','ClinicalNutrition','Pediatrition',];
  static List<String>doct=['doct1','doct2','doct3','doct4','doct5',];
  static List<String>date=['20-04-2023','20-04-2023','20-04-2023','20-04-2023','20-04-2023'];
  static List<String>time=['9.00AM','2.00PM','9.30AM','4.00PM','3.00PM',];

  final List<Appoint>model=List.generate(depart.length, (index)
  => Appoint( depart: depart[index], doct:doct[index], date:date[index], time:time[index],));
*/
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
        .getData('api/patient_token_booking/'+user_id.toString());
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
          msg:"Currently there is no booking available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
Future<void> _viewPro() async {
  var res = await Api()
      .getData('api/single_doctor/' + doc_id.toString());
  var body = json.decode(res.body);

  setState(() {
    name = body['data']['doctorname'];
    depart=body['data']['doctorname'];
    /* app_time = body['data']['appointment_time'];
      bookingnum = body['data']['number'];
      appointment_date = body['data']['appointment_date'];
*/

  });
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
            builder: (context) => MyHomePage(),
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
   /*   floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Appointment(),
          ));
        },
        tooltip: 'Appointment',
        child: const Icon(Icons.add),
      ),*/
    );
  }
}
