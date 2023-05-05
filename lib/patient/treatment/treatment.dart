
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';

class TreatmentDetails extends StatefulWidget {
  const TreatmentDetails({Key? key}) : super(key: key);

  @override
  State<TreatmentDetails> createState() => _TreatmentDetailsState();
}

class _TreatmentDetailsState extends State<TreatmentDetails> {
  List loaddata=["Disease1","Disease2"];
  List pre=["prescription","Disease2"];
  List date=["05-03-2023","04-03-2023"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title: Text("Treatment Detail"),
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
                child: Text("Treatment Detail",style: TextStyle(
                  fontSize:26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8F371B),
                ),),
              ),
              SizedBox(height:20),
              ListView.builder(
                shrinkWrap:true,
                itemCount: loaddata.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: ()async {

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: ListTile(
                         title:  Text(loaddata[index],
                            style:TextStyle(
                              fontSize: 18,fontWeight: FontWeight.bold,
                            ) ,),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text("Prescription: "+pre[index],
                              style:TextStyle(
                                fontSize: 15,fontWeight: FontWeight.bold,
                              ) ,),
                          ),
                          trailing: Text(date[index],

                          /*   ElevatedButton(onPressed: (){},
                                    child: Text("APPROVE")),
                                ElevatedButton(onPressed: (){

                                },
                                    child: Text("REJECT"))*/

                        ),
                      ),
                    ),
                  )
                  );
                },
              )
            ]),

      ),
    );
  }
}
