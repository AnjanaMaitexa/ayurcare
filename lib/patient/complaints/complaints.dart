
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/complaints/add_complaints.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  List complaints=["comp1","comp2","comp3","com4"];
  List description=["desc1","desc2","desc3","desc4"];
  List _loaddisease = [];
  bool isLoading = false;
  late int disease_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchDisease();
  }

  _fetchDisease() async {
    var res = await Api()
        .getData('api/patientadd_complaints');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddisease = items;

      });
    } else {
      setState(() {
        _loaddisease = [];
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
        title: Text("Complaint Management",style: TextStyle(color: Color(0xFF8F371B)),),
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
                  child: Text("Complaints",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8F371B)
                  ),),
                ),
                SizedBox(height:20),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap:true,
                  itemCount: complaints.length,
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
                                        Text(complaints[index]),
                                        Text(description[index]),
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
            builder: (context) => AddComplaint(),
          ));
        },
        tooltip: 'Add Complaints',
        child: const Icon(Icons.add),
      ),
    );

  }

}