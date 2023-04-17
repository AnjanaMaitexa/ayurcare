import 'package:flutter/material.dart';

Widget textContainer(
     String placeholder, TextEditingController controller) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow:[ BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: Offset(1,1),
            color: Colors.grey.withOpacity(0.2)
        )]
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: placeholder,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.0
              )
          ), enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Colors.white,
              width: 1.0
          )
      ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
          )
      ),
    ),
  );
    }
Widget textNumContainer(
    String placeholder, TextEditingController controller) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow:[ BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: Offset(1,1),
            color: Colors.grey.withOpacity(0.2)
        )]
    ),
    child: TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
          hintText: placeholder,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.0
              )
          ), enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Colors.white,
              width: 1.0
          )
      ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
          )
      ),
    ),
  );
}
Widget textEmailContainer(
    String placeholder, TextEditingController controller) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow:[ BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: Offset(1,1),
            color: Colors.grey.withOpacity(0.2)
        )]
    ),
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
          hintText: placeholder,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.0
              )
          ), enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Colors.white,
              width: 1.0
          )
      ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
          )
      ),
    ),
  );
}
