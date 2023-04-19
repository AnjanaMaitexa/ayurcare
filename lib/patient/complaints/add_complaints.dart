
import 'package:ayurvedichospital/patient/complaints/complaints.dart';
import 'package:flutter/material.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({Key? key}) : super(key: key);

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  TextEditingController _compcontroller = TextEditingController();
  TextEditingController _descontroller = TextEditingController();
  TextEditingController _locontroller = TextEditingController();
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xF5FFFFFF) ,
        appBar: AppBar(
          title: Text(" Complaints"),
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(onPressed: () {

          },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key:_formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(

                children: [

                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Complaint',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _compcontroller,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Complaint'),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _descontroller,
                    // controller: _vehicleNoController,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Description'),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Location',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _locontroller,
                    // controller: _vehicleNoController,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Location'),
                  ),


                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Complaints()));
                    },
                    child: Container(
                      width: w*0.5,
                      height:h*0.08,
                      color:  Color(0xFF772F16),
                      child: Center(
                        child: Text("SignIn",style:TextStyle(
                            fontSize:36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

}