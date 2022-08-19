// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_print

import 'package:back_end_nfc/models/mahasiswa.dart';
import 'package:back_end_nfc/screens/mahasiswa_view.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddMahasiswa extends StatefulWidget {
  const AddMahasiswa({Key? key}) : super(key: key);

  @override
  State<AddMahasiswa> createState() => _AddMahasiswaState();
}

class _AddMahasiswaState extends State<AddMahasiswa> {
  late String urlDownload;
  final TextEditingController namaMahasiswaController = TextEditingController();
  final TextEditingController nimMahasiswaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            addMahasiswa(),
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
            'Tambah Mahasiswa',
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
        // Field Nama Mahasiswa
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
            controller: namaMahasiswaController,
            decoration: InputDecoration.collapsed(
              hintText: 'Nama Mahasiswa',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Nama Mahasiswa';
              }
              return null;
            },
          ),
        ),
        // Field NIM Mahasiswa
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
            controller: nimMahasiswaController,
            decoration: InputDecoration.collapsed(
              hintText: 'NIM Mahasiswa',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'NIM Mahasiswa';
              }
              return null;
            },
          ),
        ),
        // Upload Image Dosen
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
                    .ref('image/mahasiswa/$fileName')
                    .putData(fileBytes!);

                urlDownload = await upload.ref.getDownloadURL();

                print(urlDownload);
              }
            },
            child: Text(
              'Pick Image Mahasiswa',
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

  Widget addMahasiswa() {
    return Container(
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
          // code untuk submit ke firebase
          final namaMahasiswa = namaMahasiswaController.text;
          final nimMahasiswa = nimMahasiswaController.text;
          createMahasiswa(
            namaMahasiswa: namaMahasiswa,
            nimMahasiswa: nimMahasiswa,
          );
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new MahasiswaPage(),
            ),
          );
          // add code above
        },
        child: Text(
          'Create Mahasiswa',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }

  Future createMahasiswa({
    required String namaMahasiswa,
    required String nimMahasiswa,
  }) async {
    final docMahasiswa =
        FirebaseFirestore.instance.collection('mahasiswa').doc();

    final mahasiswa = Mahasiswa(
      namaMahasiswa: namaMahasiswa,
      nimMahasiswa: nimMahasiswa,
      id: docMahasiswa.id,
      imageURL: urlDownload,
    );

    final json = mahasiswa.toJson();

    await docMahasiswa.set(json);
  }
}
