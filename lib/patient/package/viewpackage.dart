
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:ayurvedichospital/patient/package/detail_package.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewPackage extends StatefulWidget {
  const ViewPackage({Key? key}) : super(key: key);

  @override
  State<ViewPackage> createState() => _ViewPackageState();
}

class _ViewPackageState extends State<ViewPackage> {
  List _loadpackage = [];
  bool isLoading = false;
  late int package_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchData();
  }

  _fetchData() async {
    var res = await Api()
        .getData('api/get_package');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loadpackage = items;

      });
    } else {
      setState(() {
        _loadpackage = [];
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
        title: Text("Packages"),
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

              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text("Packages",style: TextStyle(
                  fontSize:26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8F371B),
                ),),
              ),
              SizedBox(height:20),
              ListView.builder(
                shrinkWrap:true,
                itemCount: _loadpackage.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: ()async {
                      package_id=_loadpackage[index]['id'];
                      print("id${package_id}");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Detailpackage(id:package_id) ));

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: ListTile(
                          leading:  CircleAvatar(
                            backgroundColor: Colors.lightBlueAccent,
                            backgroundImage:NetworkImage("http://127.0.0.1:8000"+_loadpackage[index]['package_photo']) ,),
                          title:  Text(_loadpackage[index]['package_name'],
                            style:TextStyle(
                                fontSize: 18,fontWeight: FontWeight.bold,
                            ) ,),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text("Goal: "+_loadpackage[index]['package_goal'],
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
