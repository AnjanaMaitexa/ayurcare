
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/appointment/viewappointment.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointment extends StatefulWidget {
  int id;

  Appointment({required this.id});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
String name="";
String depart="";
String app_time='';
String token="";
String image='';
String specialized='';
bool _isLoading=false;
late int did;
late int user_id;

late SharedPreferences localStorage;
final timeController = TextEditingController();
@override
void initState() {
  // TODO: implement initState
  super.initState();
  _viewPro();
}
  List department = ["Orthopaedic","Gynaecology","Cardiology","ENT"];
  String? selectdepart;
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDate='${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      });
    }
  }
  Future<void> _viewPro() async {

    did=widget.id;
    var res = await Api()
        .getData('api/single_doctor/' + did.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['doctorname'];
      depart = body['data']['doctorqualification'];
      app_time = body['data']['doctor_available_time'];
      image = body['data']['doctorprofile_photo'];
      specialized=body['data']['doctorspecialization'];

    });
  }

void addBooking()async {

  did=widget.id;
  localStorage = await SharedPreferences.getInstance();
  user_id = (localStorage.getInt('user_id') ?? 0);
  setState(() {
    _isLoading = true;
  });

  var data = {
    "doctor":did.toString() ,
    "patient":user_id.toString(),
    "appointment_date": startDate.toString(),
    "appointment_time":timeController.text,
     };
  print(data);
  // if(data.image){
  //   var res = await Api().authData(data.image, '/upload');
  //
  // }
  var res = await Api().authData(data, 'api/token_booking');
  var body = json.decode(res.body);

  if(body['success']==true)
  {
    print(body);

    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAppointment()));
    Fluttertoast.showToast(
      msg: body['message'].toString(),
      backgroundColor: Colors.grey,
    );
  }
  else
  {
    Fluttertoast.showToast(
      msg: body['message'].toString(),
      backgroundColor: Colors.grey,
    );

  }
}
  late String startDate;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Book your doctor"),
        backgroundColor:Color(0xFF8F371B),
        leading:IconButton(onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
        },
            icon: Icon(Icons.arrow_back)),
      ),
      bottomNavigationBar: Material(
        color: const Color(0xFF8F371B) ,
        child: InkWell(
          onTap: () {
            addBooking();
            //print('called on tap');
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'Book Now',
                style: TextStyle(
                fontSize:25,
                fontWeight: FontWeight.bold,
                color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body:Column(
        children: [
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
                        Text(depart, style:TextStyle(
                          fontSize: 18,color: Colors.white
                        ) ,),
                        Text(specialized, style:TextStyle(
                            fontSize: 18,color: Colors.white
                        ) ,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(top: 10.0,left: 35),
            child: Row(
              children: [
                Expanded(
                  child: Text('Available Time',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black38
                    ),),
                ),
                Expanded(
                  child: Text(app_time,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black38
                    ),),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),

          Row(

            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  height: 45,
                  width:150 ,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black38
                      ),),
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF772F16), // foreground (text) color
                ),
                onPressed: () => _selectDate(context),
                child: const Text('Select date'),
              ),

              SizedBox(height: 10),

            ],
          ),


          Padding(
            padding: const EdgeInsets.all(20.0),
            child:TextField(
              readOnly: true,
              controller: timeController,
              decoration: const InputDecoration(hintText: 'Pick your Time'),
              onTap: () async {
                var time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());

                if (time != null) {
                  timeController.text = time.format(context);
                }
              },
            ))

        ],
      ) ,
    );
  }
}
