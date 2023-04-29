
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/DiseaseDetails/detail_view.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DiseaseDetail extends StatefulWidget {
  const DiseaseDetail({Key? key}) : super(key: key);

  @override
  State<DiseaseDetail> createState() => _DiseaseDetailState();
}

class _DiseaseDetailState extends State<DiseaseDetail> {
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
        .getData('api/get_remedy');
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
      appBar: AppBar(
        elevation: 0,
        title: Text("Diseases and Remedies"),
        backgroundColor: Color(0xFF8F371B),
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
/*
                Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Text("Diseases and Remedies",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8F371B),
                  ),),
                ),*/
                SizedBox(height:20),
                ListView.builder(
                  shrinkWrap:true,
                  itemCount: _loaddisease.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: ()async {
                        disease_id=_loaddisease[index]['id'];
                        print("id${disease_id}");
                          Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailView(id:disease_id),

                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                            leading:  CircleAvatar(
                              backgroundColor: Colors.lightBlueAccent,
                              backgroundImage:NetworkImage("http://127.0.0.1:8000"+_loaddisease[index]['remedy_photo']) ,),
                            title:  Text(_loaddisease[index]['disease'],
                              style:TextStyle(
                                fontSize: 18,fontWeight: FontWeight.bold,
                              ) ,),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text("Symptoms: "+_loaddisease[index]['symptoms'],
                                style:TextStyle(
                                  fontSize: 15,fontWeight: FontWeight.bold,
                                ) ,),
                            ),

                            /*   ElevatedButton(onPressed: (){},
                                    child: Text("APPROVE")),
                                ElevatedButton(onPressed: (){

                                },
                                    child: Text("REJECT"))*/

                          ),
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
