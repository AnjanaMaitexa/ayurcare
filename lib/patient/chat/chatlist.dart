
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/chat/chat.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  bool isLoaded=false;
  late int doct_id;
  String department='';
  String doc_name='';
  String doc_image='';
  List _loaddata = [];
  bool isLoading = false;

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
            child: ListView.builder(
            shrinkWrap:true,
            itemCount: _loaddata.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: ()async{
                  doct_id=_loaddata[index]['id'];
                  doc_name=_loaddata[index]['doctorname'];
                  doc_image="http://127.0.0.1:8000"+_loaddata[index]['doctorprofile_photo'];

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Chat(id:doct_id,name:doc_name,image:doc_image),

                  ));
                },
                child: Card(
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

                    /*   ElevatedButton(onPressed: (){},
                          child: Text("APPROVE")),
                      ElevatedButton(onPressed: (){

                      },
                          child: Text("REJECT"))*/

                  ),
                ),
              );
            },
                ),
          ),
          /*  replacement:Center(
                child: const CircularProgressIndicator(),
              )

          ),*/

        ));
  }
}
