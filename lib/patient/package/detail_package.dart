import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/DiseaseDetails/detail.dart';
import 'package:ayurvedichospital/patient/package/viewpackage.dart';
import 'package:flutter/material.dart';

class Detailpackage extends StatefulWidget {
  final int id;

  Detailpackage({required this.id});

  @override
  State<Detailpackage> createState() => _DetailpackageState();
}

class _DetailpackageState extends State<Detailpackage> {
  String packagename = "";
  String package_goal = "";
  String package_description = "";
  String package_duration = "";
  String package_price = "";
  String package_photo = "";
  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    int remid = widget.id;
    print("id${remid}");
    var res = await Api().getData('api/single_package/' + remid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      packagename = body['data']['package_name'];
      package_goal = body['data']['package_goal'];
      package_description = body['data']['package_description'];
      package_duration = body['data']['package_duration'];
      package_price = body['data']['package_price'];
      package_photo = body['data']['package_photo'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(packagename),
        backgroundColor: Color(0xFF8F371B),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewPackage(),
              ));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        "http://127.0.0.1:8000" + package_photo,
                      ),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    packagename,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LuxuriousRoman',
                      color: Color(0xFF8F371B),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Goal: ' + package_goal,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      package_description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Duration  ' + package_duration,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Price: Rs.${package_price}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LuxuriousRoman',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
