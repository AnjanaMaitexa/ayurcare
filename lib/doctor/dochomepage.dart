import 'dart:convert';
import 'package:ayurvedichospital/doctor/profile/profileview.dart';
import 'package:ayurvedichospital/doctor/viewappointments/appoints.dart';
import 'package:ayurvedichospital/doctor/viewtreatment/ViewTreatment.dart';
import 'package:ayurvedichospital/patient/model/homemodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DoHomePage extends StatefulWidget {
  const DoHomePage({Key? key}) : super(key: key);

  @override
  State<DoHomePage> createState() => _DoHomePageState();
}

class _DoHomePageState extends State<DoHomePage> {


  @override
  Widget build(BuildContext context) {
    List gridlist = [
      HomeModel(image: "images/aware.jpg", title: "Profile"),
      HomeModel(image: "images/booking.jpg", title: "Appointment\nDetails"),
      HomeModel(image: "images/treat.jpg", title: "Treatment\nDetails"),
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
                                builder: (context) => ProfileView()),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAppoints()),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VTreatmentDetails()),
                          );
                          break;
                        case 3:

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

    );
  }
}
