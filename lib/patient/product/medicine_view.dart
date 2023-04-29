
import 'dart:convert';

import 'package:ayurvedichospital/api.dart';
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:ayurvedichospital/patient/package/detail_package.dart';
import 'package:ayurvedichospital/patient/product/detail_product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Medicine extends StatefulWidget {
  const Medicine({Key? key}) : super(key: key);

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  List _loadpackage = [];
  bool isLoading = false;
 late  int product_id;
  late int package_id;
  CarouselController buttonCarouselController = CarouselController();
  List images = ['images/img1.jpg', 'images/img2.jpg', 'images/img3.jpg'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchData();
  }

  _fetchData() async {
    var res = await Api()
        .getData('api/get_medicine');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loadpackage = items;

      });
    } else {
      setState(() {
        _loadpackage = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Products"),
        backgroundColor: Color(0xFF8F371B),
        leading:IconButton(onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
        },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int itemIndex,
                int pageViewIndex) =>
                Container(
                  decoration: BoxDecoration(image: DecorationImage(
                      image: AssetImage(images[itemIndex]),
                      fit: BoxFit.cover
                  ),),
                ),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(microseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 4 / 5.4,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
              ),
              itemCount: _loadpackage.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: (){
                      product_id=_loadpackage[index]['id'];
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailProduct(id:product_id),

                      ));
                    },
                    child: GridTile(
                      //  key: ValueKey(_products[index]['id']),
                      footer: Container(
                        height: 40,
                        child: GridTileBar(

                          backgroundColor: Colors.black54,
                          title: Text(
                            _loadpackage[index]['medicine_name'],
                            style:  TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'LuxuriousRoman',),
                          ),
                          subtitle: Text("\₹ ${ _loadpackage[index]['medicine_price']}",style: const TextStyle(
                             fontFamily: 'LuxuriousRoman',),),
                     //   trailing:  Icon(Icons.shopping_cart),

                        ),
                      ),

                      child: Image.network(
                        "http://127.0.0.1:8000" +_loadpackage[index]['medicine_photo'],fit: BoxFit.fitHeight,
                      ),

                    ),
                  ),
                );
              }),

        ],
      ),

    );
  }
}
