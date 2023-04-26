
import 'package:ayurvedichospital/patient/doctors/addappointment.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {

  bool isLoaded=false;
  String department='';
  List doctors=["doc1","doc2","doc3","doc4","doc5","doc4","doc5"];
  List departs=["depart1","depart2","depart3","depart4","depart5","depart4","depart5"];
  List images=["images/doc1.jpg","images/doc1.jpg","images/doc1.jpg","images/doc1.jpg","images/doc1.jpg","images/doc1.jpg","images/doc1.jpg"];

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
                                    //  getCityWeather(text);
                                      setState(() {
                                        isLoaded=false;
                                      });
                                    });
                                  },
                                  controller: departmentController,
                                  cursorColor:Colors.white,
                                  style:TextStyle(
                                    fontSize:20,
                                    color: Colors.white.withOpacity(0.7),
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


                     /* SizedBox(
                        height: 80, ),
                      Text(cityname,style: (TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                      )),),
                      Text("Saturday,Feb,2021",style: (TextStyle(
                        fontSize:16,
                        color: Colors.white,
                      )),),
                      SizedBox(
                        height:130, ),
                      Padding(
                        padding: EdgeInsets.only(left:39.0),
                        child: Icon(Icons.cloud,
                            size: 50,
                            color: Colors.white
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:18.0),
                        child: Text('cloud',style: (TextStyle(
                          fontSize:16,
                          color: Colors.white,
                        )),),
                      ),
                      SizedBox(
                        height:10, ),
                      Padding(
                        padding: EdgeInsets.only(left:18.0),
                        child: Text('Pressure:${pressure?.toInt()}hPa',style: (TextStyle(
                          fontSize:16,
                          color: Colors.white,
                        )),),

                      ),
                      Padding(
                        padding: EdgeInsets.only(left:18.0),
                        child: Text('Humidity:${humidity?.toInt()}%',style: (TextStyle(
                          fontSize:16,
                          color: Colors.white,
                        )),),

                      ),
                      SizedBox(
                        height:120, ),
                      Padding(
                        padding: EdgeInsets.only(left:18.0),
                        child: Text('${temp?.toInt()}°C',style: (TextStyle(
                            fontSize:90,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),),
                      ),*/
                      SizedBox(height: 10,),
                      ListView.builder(
                        shrinkWrap:true,
                        itemCount: doctors.length,
                        itemBuilder: (context,index){
                          return Card(
                            child: ListTile(
                              leading:  CircleAvatar(
                                backgroundColor: Colors.lightBlueAccent,
                                backgroundImage:AssetImage(images[index]) ,),
                              title:  Text(doctors[index],
                                style:TextStyle(
                                  fontSize: 18,
                                ) ,),
                              subtitle: Text(departs[index],
                                style:TextStyle(
                                  fontSize: 18,
                                ) ,),
                              trailing: IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Appointment()));

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
