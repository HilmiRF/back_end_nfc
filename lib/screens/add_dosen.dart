// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_local_variable, use_build_context_synchronously, unnecessary_brace_in_string_interps, avoid_print, await_only_futures

import 'dart:io';
import 'dart:typed_data';

import 'package:back_end_nfc/models/dosen.dart';
import 'package:back_end_nfc/screens/dosen_view.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddDosen extends StatefulWidget {
  const AddDosen({Key? key}) : super(key: key);

  @override
  State<AddDosen> createState() => _AddDosenState();
}

class _AddDosenState extends State<AddDosen> {
  late String urlDownload;

  final TextEditingController namaDosenController = TextEditingController();
  final TextEditingController nipDosenController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteGreyColor,
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            title(),
            SizedBox(
              height: 10,
            ),
            form(),
            SizedBox(
              height: 10,
            ),
            addDosen(),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      margin: EdgeInsets.only(
        top: 38,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tambah Dosen',
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 87,
                height: 4,
                margin: EdgeInsets.only(
                  right: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kBlackColor,
                ),
              ),
              Container(
                width: 8,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kBlackColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
        // Field Nama Dosen
        Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          padding: EdgeInsets.all(18),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: kWhiteColor,
          ),
          child: TextFormField(
            controller: namaDosenController,
            decoration: InputDecoration.collapsed(
              hintText: 'Nama Dosen',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Nama Dosen';
              }
              return null;
            },
          ),
        ),
        // Field NIP Dosen
        Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          padding: EdgeInsets.all(18),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: kWhiteColor,
          ),
          child: TextFormField(
            controller: nipDosenController,
            decoration: InputDecoration.collapsed(
              hintText: 'NIP Dosen',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'NIP Dosen';
              }
              return null;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: kBlackColor,
          ),
          child: TextButton(
            onPressed: () async {
              final result = await FilePicker.platform
                  .pickFiles(type: FileType.any, allowMultiple: false);

              if (result != null && result.files.isNotEmpty) {
                final fileBytes = result.files.first.bytes;
                final fileName = result.files.first.name;

                // upload file
                final upload = await FirebaseStorage.instance
                    .ref('image/dosen/$fileName')
                    .putData(fileBytes!);

                urlDownload = await upload.ref.getDownloadURL();

                print(urlDownload);
              }
            },
            child: Text(
              'Pick Image Dosen',
              style: whiteTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget addDosen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: kBlackColor,
          ),
          child: TextButton(
            onPressed: () {
              // uploadFile();
              // code untuk submit ke firebase
              final namaDosen = namaDosenController.text;
              final nipDosen = nipDosenController.text;
              createDosen(
                namaDosen: namaDosen,
                nipDosen: nipDosen,
                imageURL: urlDownload,
              );
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new DosenPage(),
                ),
              );
              // add code above
            },
            child: Text(
              'Create Dosen',
              style: whiteTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future createDosen({
    required String namaDosen,
    required String nipDosen,
    required String imageURL,
  }) async {
    final docDosen = FirebaseFirestore.instance.collection('dosen').doc();

    final dosen = Dosen(
      namaDosen: namaDosen,
      nipDosen: nipDosen,
      id: docDosen.id,
      imageURL: imageURL,
    );

    final json = dosen.toJson();

    await docDosen.set(json);
  }
}
