import 'dart:async';
import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:uts/home.dart';
import 'package:uts/success/upload_success.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String _image =
      'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';
  late AnimationController loadingController;

  File? _file;
  PlatformFile? _platformFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ratingController = TextEditingController();

  selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
        _platformFile = result.files.first;
      });

      loadingController.reset();
      loadingController.forward();
    }
  }

  Future<void> uploadFile(
      {String? name, String? author, int? price, int? rating}) async {
    if (_file == null) return;

    try {
      final fileName = _platformFile!.name;
      final destination = 'files/$fileName';

      final ref = FirebaseStorage.instance.ref(destination);
      final uploadTask = ref.putFile(_file!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          loadingController.value =
              snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });

      final snapshot = await uploadTask.whenComplete(() {});
      final downloadURL = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('books').add({
        'name': name,
        'author': author,
        'price': price,
        'rating': rating,
        'fileURL': downloadURL,
        'uploadedAt': Timestamp.now(),
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThankYouPage(title: '')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while uploading file: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    checkPermission();
  }

  Future<void> checkPermission() async {
    final status = await Permission.storage.request();
    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please allow storage permission to upload files")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Image.network(
              _image,
              width: 300,
            ),
            SizedBox(height: 50),
            Text(
              'Upload your file',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'File harus jpg, png',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: selectFile,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  dashPattern: [10, 4],
                  strokeCap: StrokeCap.round,
                  color: Colors.blue.shade400,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50.withOpacity(.3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.folder_open,
                          color: Colors.blue,
                          size: 40,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Pilih file',
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _platformFile != null
                ? Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected File',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: Offset(0, 1),
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _file!,
                                  width: 70,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _platformFile!.name,
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${(_platformFile!.size / 1024).ceil()} KB',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade500),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      height: 5,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue.shade50,
                                      ),
                                      child: LinearProgressIndicator(
                                        value: loadingController.value,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nama...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Nama Penulis',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: authorController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nama Penulis...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Harga',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      hintText: 'Harga...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Rating',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: ratingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Rating...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      uploadFile(
                          author: authorController.text,
                          name: nameController.text,
                          price: int.parse(priceController.text),
                          rating: int.parse(ratingController.text));
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
