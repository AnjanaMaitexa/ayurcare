
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {

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
        startDate='${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
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
                    backgroundImage:AssetImage("images/doc1.jpg") ,),
                  SizedBox(
                    width: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name", style:TextStyle(
                      fontSize: 23,color: Colors.white
                    ) ,),
                        Text("Department", style:TextStyle(
                          fontSize: 18,color: Colors.white
                        ) ,),
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
                  child: Text('1.00PM - 3.00PM',
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
            ],
          ),


        ],
      ) ,
    );
  }
}
