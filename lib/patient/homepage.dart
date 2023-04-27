import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ayurvedichospital/patient/DiseaseDetails/detail.dart';
import 'package:ayurvedichospital/patient/doctors/addappointment.dart';
import 'package:ayurvedichospital/patient/appointment/viewappointment.dart';
import 'package:ayurvedichospital/patient/awareness/aware.dart';
import 'package:ayurvedichospital/patient/complaints/complaints.dart';
import 'package:ayurvedichospital/patient/doctors/doctors.dart';
import 'package:ayurvedichospital/patient/model/homemodel.dart';
import 'package:ayurvedichospital/patient/treatment/treatment.dart';
import 'package:ayurvedichospital/patient/userprofile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    final response =
    await http.get(Uri.parse('https://example.com/data.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        items = List<String>.from(data);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    List gridlist = [
      HomeModel(image: "images/aware.jpg", title: "Awareness"),
      HomeModel(image: "images/disease.jpg", title: "Disease\nDetails"),
      HomeModel(image: "images/treat.jpg", title: "Treatment\nDetails"),
      HomeModel(image: "images/dc.jpg", title: "Doctors"),
      HomeModel(image: "images/booking.jpg", title: "View\nAppointments"),
      HomeModel(image: "images/package.jpg", title: "Packages"),
      HomeModel(image: "images/herb.png", title: "Products"),
    ];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF8F371B),
          title: Text(
            "Ayurcare",
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 200.0),
              items: [
                "images/la.jpg",
                "images/bg2.jpg",
                "images/bg3.jpg",
                "images/la.jpg",
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: w,
                      height: 00,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("$i"), fit: BoxFit.cover)),
                    );
                  },
                );
              }).toList(),
            ),
            GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 170,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: gridlist.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Awareness()),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiseaseDetail()),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TreatmentDetails()),
                          );
                          break;
                        case 3:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorsList()),
                          );
                          break;
                        case 4:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAppointment()),
                          );
                          break;
                        // Add more cases for additional pages
                      }
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(gridlist[index].image),
                          radius: 40.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            gridlist[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'LuxuriousRoman',
                              fontSize: 18,
                              color: Color(0xFF8F371B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("User"),
              accountEmail: Text("user@gmail.com"),
              decoration: BoxDecoration(
                color: Color(0xFF8F371B), // Set your desired header color here
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/profile1.png"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.task_rounded),
              title: Text("Complaints"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Complaints()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
