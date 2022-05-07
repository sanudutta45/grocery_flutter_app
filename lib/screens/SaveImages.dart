import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SaveImages extends StatefulWidget {
  const SaveImages({Key? key}) : super(key: key);

  @override
  State<SaveImages> createState() => _SaveImagesState();
}

class _SaveImagesState extends State<SaveImages> {
  late File _imageFile;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: "gs://grocery-6fc86.appspot.com");

  final CollectionReference banners =
      FirebaseFirestore.instance.collection('banners');

  Future<void> _pickImage() async {
    XFile? selected =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (selected != null) {
      _imageFile = File(selected.path);
    }
  }

  Future<void> upload() async {
    try {
      TaskSnapshot uploadTask = await _storage
          .ref("images/banners/${DateTime.now()}.png")
          .putFile(_imageFile);

      String downloadUrl = await uploadTask.ref.getDownloadURL();

      await banners.add({"bannerUrl": downloadUrl});
      Get.snackbar("Upload Banner", "Banner image uploaded successfully");
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          IconButton(onPressed: () => _pickImage(), icon: Icon(Icons.image)),
          TextButton(onPressed: () => upload(), child: Text("Upload"))
        ]),
      ),
    );
  }
}
