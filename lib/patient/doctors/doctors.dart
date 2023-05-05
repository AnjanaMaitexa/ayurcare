
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/doctors/addappointment.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {

  bool isLoaded=false;
  String department='';

  List _loaddata = [];
  bool isLoading = false;
  late int disease_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchData();
  }

  _fetchData() async {
    var res = await Api()
        .getData('api/get_alldoctor');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;

      });
    } else {
      setState(() {
        _loaddata = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
  _fetchDataSpecial(String text) async {
    var data = {
      "query": text,
    };
    print('query${data}');
    var res = await Api()
        .authData(data,'api/patientsearch_doctor');
    print('res${res}');
    var body = json.decode(res.body);
    print('res${body}');

    if(body['success']==true)
    {
      var items = json.decode(res.body)['data'];
      print('specialdata${items}');
      setState(() {
        _loaddata = items;

      });
    } else {
      setState(() {
        _loaddata = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
  TextEditingController departmentController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text("Doctors"),
            backgroundColor: Color(0xFF8F371B),
            leading:IconButton(onPressed:(){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ));
            },
                icon: Icon(Icons.arrow_back)),
          ),
          body:/* Visibility(
              visible: isLoaded,
              child:*/
            Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.07,
                            padding:EdgeInsets.symmetric(
                                horizontal: 10
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(Radius.circular(20,),)
                            ),
                            child:Center(
                              child: TextFormField(
                                  onFieldSubmitted: (String text){
                                    setState(() {
                                      department=text;
                                      _fetchDataSpecial(text);
                                      setState(() {
                                        isLoaded=false;
                                      });
                                    });
                                  },
                                  controller: departmentController,
                                  cursorColor:Colors.white,
                                  style:TextStyle(
                                    fontSize:20,
                                    color: Colors.black,
                                  ),
                                  decoration:InputDecoration(
                                      hintText: 'Search department',
                                      hintStyle:TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search_rounded,
                                        size:25,
                                        color: Colors.white,
                                      ),
                                      border:InputBorder.none
                                  )
                              ),
                            )

                        ),
                      ),

                      SizedBox(height: 10,),
                      ListView.builder(
                        shrinkWrap:true,
                        itemCount: _loaddata.length,
                        itemBuilder: (context,index){

                          int id=_loaddata[index]['id'];
                          return Card(
                            child: ListTile(
                              leading:  CircleAvatar(
                                backgroundColor: Colors.lightBlueAccent,
                                backgroundImage:NetworkImage("http://127.0.0.1:8000"+_loaddata[index]['doctorprofile_photo']),),
                              title:  Text(_loaddata[index]['doctorname'],
                                style:TextStyle(
                                  fontSize: 18,
                                ) ,),
                              subtitle: Text(_loaddata[index]['doctorspecialization'],
                                style:TextStyle(
                                  fontSize: 18,
                                ) ,),
                              trailing: IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Appointment(id:id)));

                              }, icon: Icon(Icons.chevron_right)),

                              /*   ElevatedButton(onPressed: (){},
                                child: Text("APPROVE")),
                            ElevatedButton(onPressed: (){

                            },
                                child: Text("REJECT"))*/

                            ),
                          );
                        },
                      )
                    ],
                  ),

                ),
              ),
            /*  replacement:Center(
                child: const CircularProgressIndicator(),
              )

          ),*/

        ));
  }
}
