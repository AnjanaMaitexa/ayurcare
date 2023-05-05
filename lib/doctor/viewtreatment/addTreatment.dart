
import 'package:ayurvedichospital/doctor/dochomepage.dart';
import 'package:ayurvedichospital/doctor/viewtreatment/ViewTreatment.dart';
import 'package:flutter/material.dart';

class AddTreatment extends StatefulWidget {
  const AddTreatment({Key? key}) : super(key: key);

  @override
  State<AddTreatment> createState() => _AddTreatmentState();
}

class _AddTreatmentState extends State<AddTreatment> {
  TextEditingController age = TextEditingController();
  TextEditingController diseasecontroller = TextEditingController();
  TextEditingController discripcontroller = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book your doctor"),
        backgroundColor:Color(0xFF8F371B),
        leading:IconButton(onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DoHomePage(),
          ));
        },
            icon: Icon(Icons.arrow_back)),
      ),
      bottomNavigationBar: Material(
        color: const Color(0xFF8F371B) ,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VTreatmentDetails(),
            ));
            //print('called on tap');
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'Submit',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Prescription',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black38),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Disease',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black38),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: diseasecontroller,
                // controller: _vehicleNoController,
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Disease'),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Symptoms',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black38),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: discripcontroller,
                // controller: _vehicleNoController,
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Symptoms'),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Prescription',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black38),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: discripcontroller,
                // controller: _vehicleNoController,
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Prescription'),
              ),
              SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}
