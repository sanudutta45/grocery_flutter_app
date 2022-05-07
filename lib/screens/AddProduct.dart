import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  String productName = "";
  int totalUnit = 0;
  String brand = "";
  double costPerUnit = 0.00;
  String unit = "";
  late File img;

  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: "gs://grocery-6fc86.appspot.com");

  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void> _pickImage() async {
    XFile? selected =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (selected != null) {
      img = File(selected.path);
    }
  }

  onSubmit() async {
    String imgUrl = "";
    try {
      TaskSnapshot uploadTask = await _storage
          .ref("images/products/${DateTime.now()}.png")
          .putFile(img);

      String downloadUrl = await uploadTask.ref.getDownloadURL();
      imgUrl = downloadUrl;
    } on FirebaseException catch (e) {
      print(e);
    }

    await products.add({
      "productName": productName,
      "brand": brand,
      "imgUrl": imgUrl,
      "unit": unit,
      "totalUnit": totalUnit,
      "cost": costPerUnit,
      "discountPercentage": 45
    });

    Get.snackbar("Product Upload", "Product added successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (e) => productName = e,
                decoration: InputDecoration(
                  hintText: "product name",
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (e) {
                  if (e.length > 0) totalUnit = int.parse(e);
                },
                decoration: InputDecoration(
                  hintText: "total unit",
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (e) => brand = e,
                decoration: InputDecoration(
                  hintText: "brand name",
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (e) {
                  if (e.length > 0) costPerUnit = double.parse(e);
                },
                decoration: InputDecoration(
                  hintText: "product cost",
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (e) => unit = e,
                decoration: InputDecoration(
                  hintText: "unit",
                ),
              ),
              IconButton(
                  onPressed: () => _pickImage(), icon: Icon(Icons.image)),
              TextButton(onPressed: () => onSubmit(), child: Text("Submit"))
            ],
          ),
        ),
      )),
    );
  }
}
