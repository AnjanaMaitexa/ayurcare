
import 'package:ayurvedichospital/patient/homepage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Awareness extends StatefulWidget {
  const Awareness({Key? key}) : super(key: key);

  @override
  State<Awareness> createState() => _AwarenessState();
}

class _AwarenessState extends State<Awareness> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Awareness",style: TextStyle(color: Color(0xFF8F371B)),),
        backgroundColor: Colors.white ,
        leading:IconButton(onPressed:(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
        },
            icon: Icon(Icons.arrow_back,color: Color(0xFF8F371B))),
      ),
     body: Center(
       child:WebView(
         zoomEnabled: true ,
         initialUrl:"https://medicaldialogues.in/ayush/ayurveda/news",
         javascriptMode: JavascriptMode.unrestricted,
         onWebViewCreated: (WebViewController webViewController){
           _controller = webViewController;
         },
       )
     ),
    );
  }
}
