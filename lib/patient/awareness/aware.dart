
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';

class Awareness extends StatefulWidget {
  const Awareness({Key? key}) : super(key: key);

  @override
  State<Awareness> createState() => _AwarenessState();
}

class _AwarenessState extends State<Awareness> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Awareness",style: TextStyle(color: Color(0xFF8F371B)),),
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
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Awareness",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8F371B)
                  ),),
                ),
                SizedBox(height:20),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap:true,
                  itemCount:10,
                  itemBuilder: (context,index){
                    return Card(
                        child:Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.lightBlueAccent,
                                    backgroundImage:AssetImage("images/aware.jpg" ,),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("News"),
                                        Text("Description"),
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


    );
  }
}
