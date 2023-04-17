import 'package:ayurvedichospital/patient/model/homemodel.dart';
import 'package:ayurvedichospital/patient/userprofile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    List gridlist = [
      HomeModel(image: "images/aware.jpg",title:"Awareness"),
      HomeModel(image: "images/disease.jpg",title:"DiseaseDetails"),
      HomeModel(image: "images/treat.jpg",title:"TreatmentDetails"),
      HomeModel(image: "images/dc.jpg",title:"Doctors"),
      HomeModel(image: "images/booking.jpg",title:"Appointment"),

    ];

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8F371B),
          title: Text("Ayurcare",style: TextStyle(color: Colors.white),)),
      body: SingleChildScrollView(
        physics:ScrollPhysics() ,
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 200.0),
              items: ["images/la.jpg","images/bg2.jpg","images/bg3.jpg","images/la.jpg"].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return  Container(
                      width: w,
                      height:00,
                      decoration: BoxDecoration(
                          image:DecorationImage(
                              image: AssetImage(
                                  "$i"
                              ),
                              fit: BoxFit.cover
                          )
                      ),
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
                    maxCrossAxisExtent:170,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: gridlist.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor:Colors.white,
                  backgroundImage: AssetImage(gridlist[index].image),
                  radius: 40.0,),
                    Text(gridlist[index].title,style: TextStyle(fontFamily:'LuxuriousRoman',fontSize: 18,
                    color: Color(0xFF8F371B),),),
                  ],
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
                color:  Color(0xFF8F371B), // Set your desired header color here
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/profile1.png"),
              ),

            ),

            ListTile(
              leading: Icon(Icons.home), title: Text("Home"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()),);
              },
            ),

            ListTile(
              leading: Icon(Icons.person), title: Text("Profile"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile()),);
              },
            ),

            ListTile(
              leading: Icon(Icons.task_rounded), title: Text("Complaints"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings), title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts), title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout), title: Text("Logout"),
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