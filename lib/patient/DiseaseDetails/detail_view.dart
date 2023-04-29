import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/DiseaseDetails/detail.dart';
import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  final int id;

  DetailView({required this.id});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  String disease = "";
  String symptom = "";
  String remedy = "";
  String image = "";
  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    int remid = widget.id;
    print("id${remid}");
    var res = await Api().getData('api/single_remedy/' + remid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      disease = body['data']['disease'];
      symptom = body['data']['symptoms'];
      remedy = body['data']['remedy'];
      image = body['data']['remedy_photo'];

      print("imagename${image}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(disease),
        backgroundColor: Color(0xFF8F371B),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DiseaseDetail(),
              ));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage("http://127.0.0.1:8000" + image),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  disease,
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
                    'Symptoms',
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
                    symptom,
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
                    'Remedy',
                    textAlign: TextAlign.justify,
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
                    remedy,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'LuxuriousRoman',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
