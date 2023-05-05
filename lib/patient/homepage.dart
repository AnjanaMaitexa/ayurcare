import 'dart:convert';
import 'package:ayurvedichospital/loginpage.dart';
import 'package:ayurvedichospital/patient/chat/chat.dart';
import 'package:ayurvedichospital/patient/chat/chatlist.dart';
import 'package:ayurvedichospital/patient/feedback/viewfeedback.dart';
import 'package:ayurvedichospital/patient/package/viewpackage.dart';
import 'package:ayurvedichospital/patient/product/medicine_view.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    late SharedPreferences localStorage;
    List gridlist = [
      HomeModel(image: "images/aware.jpg", title: "Awareness"),
      HomeModel(image: "images/disease.jpg", title: "Disease\nDetails"),
      HomeModel(image: "images/treat.jpg", title: "Treatment\nDetails"),
      HomeModel(image: "images/dc.jpg", title: "Doctors"),
      HomeModel(image: "images/booking.jpg", title: "View\nAppointments"),
      HomeModel(image: "images/package.jpg", title: "Packages"),
      HomeModel(image: "images/herb.png", title: "Products"),
      HomeModel(image: "images/chat.png", title: "Chat"),
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
                          case 5:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewPackage()),
                        );
                        break;
                        case 6:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Medicine()),
                          );
                          break;
                        case 7:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatList()),
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
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewFeed()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () async {
                localStorage = await SharedPreferences.getInstance();
                localStorage.setBool('login', true);
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => LoginPage()));

              },
            ),
          ],
        ),
      ),
    );
  }
}
