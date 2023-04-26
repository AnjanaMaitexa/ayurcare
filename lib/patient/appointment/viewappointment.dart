
import 'package:ayurvedichospital/patient/doctors/addappointment.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:ayurvedichospital/patient/model/appoint.dart';
import 'package:flutter/material.dart';

class ViewAppointment extends StatefulWidget {
  const ViewAppointment({Key? key}) : super(key: key);

  @override
  State<ViewAppointment> createState() => _ViewAppointmentState();
}

class _ViewAppointmentState extends State<ViewAppointment> {
  static List<String>depart=['Cardiology','ENT','Orthopaedics','ClinicalNutrition','Pediatrition',];
  static List<String>doct=['doct1','doct2','doct3','doct4','doct5',];
  static List<String>date=['20-04-2023','20-04-2023','20-04-2023','20-04-2023','20-04-2023'];
  static List<String>time=['9.00AM','2.00PM','9.30AM','4.00PM','3.00PM',];

  final List<Appoint>model=List.generate(depart.length, (index)
  => Appoint( depart: depart[index], doct:doct[index], date:date[index], time:time[index],));

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
                itemCount: depart.length,
                itemBuilder: (context,index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         Text("Doctor: "+model[index].doct,
                           style:TextStyle(
                             fontSize: 18,
                           ) ,),
                         SizedBox(height: 10,),
                         Row(
                          children: [
                             Text(model[index].date,
                               style:TextStyle(
                                 fontSize: 18,
                               ) ,),
                            SizedBox(width: 35,),
                             Text(model[index].time,
                               style:TextStyle(
                                 fontSize: 18,
                               ) ,),
                           ],
                         ),


                       ],
                      ),
                    ),
                  );
                },
              )
            ]),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Appointment(),
          ));
        },
        tooltip: 'Appointment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
