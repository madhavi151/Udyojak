import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class demo extends StatefulWidget {
  const demo({super.key});

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
TextEditingController name = TextEditingController();
TextEditingController Contactno = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController image = TextEditingController();
TextEditingController email  = TextEditingController();

    return Scaffold(
    body: Column(
      children: [
        TextField(
          controller: name,
          decoration: InputDecoration(
            labelText: 'Name'
          ),
        ),
        TextField(
          controller: image,
          decoration: InputDecoration(
              labelText: 'image'
          ),
        ),
        TextField(
          controller: email,
          decoration: InputDecoration(
              labelText: 'email'
          ),
        ),
        TextField(
          controller: description,
          decoration: InputDecoration(
              labelText: 'description'
          ),
        ),
        TextField(
          controller: Contactno,
          decoration: InputDecoration(
              labelText: 'Contact no'
          ),
        ),
        TextField(
          controller: address,
          decoration: InputDecoration(
              labelText: 'address'
          ),
        ),
        ElevatedButton(onPressed: (){
          FirebaseFirestore.instance.collection("Products").doc().set({
            "name":name.text,
            "address":address.text,
            "email":email.text,
            "description":description.text,
            "Contactno":Contactno.text,
            "image":image.text
          });
        
        }, child: Text("Submit"))
      ],
    ),
    );
  }
}
