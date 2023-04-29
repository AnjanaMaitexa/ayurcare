
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/product/medicine_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DetailProduct extends StatefulWidget {
  final int id;

  DetailProduct({required this.id});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  String medicine_name = "";
  String medicine_qnty = "";
  String medicine_description = "";
  String medicine_dosage = "";
  String medicine_usage = "";
  String medicine_price = "";
  String medicine_photo = "";
  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    int remid = widget.id;
    print("id${remid}");
    var res = await Api().getData('api/single_medicine/' + remid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      medicine_name = body['data']['medicine_name'];
      medicine_qnty = body['data']['medicine_qnty'];
      medicine_description = body['data']['medicine_description'];
      medicine_dosage = body['data']['medicine_dosage'];
      medicine_usage = body['data']['medicine_usage'];
      medicine_price = body['data']['medicine_price'];
      medicine_photo = body['data']['medicine_photo'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(medicine_name),
        backgroundColor: Color(0xFF8F371B),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Medicine(),
              ));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 230,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(
                          "http://127.0.0.1:8000" + medicine_photo,
                        ),
                        fit: BoxFit.fitHeight)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        medicine_name,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LuxuriousRoman',
                          color: Color(0xFF8F371B),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Price: Rs. ' + medicine_price,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LuxuriousRoman',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ), Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Available stock ' + medicine_qnty,
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
                    Divider(
                      thickness: 2,
                    ), SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Product Details',
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

                    RichText(text:TextSpan(
                        text:"Description : ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LuxuriousRoman',
                        ),
                        children: [
                          TextSpan(
                         //   recognizer: TapGestureRecognizer()..onTap=()=>Navigator.pop(context),
                            text:medicine_description,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 20,
                                fontFamily: 'LuxuriousRoman',
                                fontWeight: FontWeight.bold
                            ),

                          )
                        ]
                    )),
                    SizedBox(
                      height: 10,
                    ),

                    RichText(text:TextSpan(
                        text:"Dosage : ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LuxuriousRoman',
                        ),
                        children: [
                          TextSpan(
                            //   recognizer: TapGestureRecognizer()..onTap=()=>Navigator.pop(context),
                            text:medicine_dosage,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 20,
                                fontFamily: 'LuxuriousRoman',
                                fontWeight: FontWeight.bold
                            ),

                          )
                        ]
                    )),
                    SizedBox(
                      height: 10,
                    ),

                    RichText(text:TextSpan(
                        text:"Usage : ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LuxuriousRoman',
                        ),
                        children: [
                          TextSpan(
                            //   recognizer: TapGestureRecognizer()..onTap=()=>Navigator.pop(context),
                            text:medicine_usage,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 20,
                                fontFamily: 'LuxuriousRoman',
                                fontWeight: FontWeight.bold
                            ),

                          )
                        ]
                    )),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
