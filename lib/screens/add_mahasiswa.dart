// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_print, use_build_context_synchronously

import 'package:back_end_nfc/models/mahasiswa.dart';
import 'package:back_end_nfc/screens/mahasiswa_view.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class AddMahasiswa extends StatefulWidget {
  const AddMahasiswa({Key? key}) : super(key: key);

  @override
  State<AddMahasiswa> createState() => _AddMahasiswaState();
}

late String idMHS;

class _AddMahasiswaState extends State<AddMahasiswa> {
  bool isDataError = false;
  ValueNotifier<dynamic> result = ValueNotifier(null);
  late String urlDownload = '';
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
            SizedBox(
              height: 10,
            ),
            registerNFC(),
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
        if (isDataError == true)
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'Masukkan Data dengan Lengkap',
              style: redTextStyle,
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
          if (namaMahasiswaController.text.isNotEmpty &&
              nimMahasiswaController.text.isNotEmpty) {
            // code untuk submit ke firebase
            final namaMahasiswa = namaMahasiswaController.text;
            final nimMahasiswa = nimMahasiswaController.text;
            createMahasiswa(
              namaMahasiswa: namaMahasiswa,
              nimMahasiswa: nimMahasiswa,
            );
          } else {
            setState(() {
              isDataError = true;
            });
            print('Isi Data');
          }

          // Navigator.push(
          //   context,
          //   new MaterialPageRoute(
          //     builder: (context) => new MahasiswaPage(),
          //   ),
          // );
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

  Widget registerNFC() {
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
        onPressed: () async {
          final namaMahasiswa = namaMahasiswaController.text;
          final nimMahasiswa = nimMahasiswaController.text;
          bool isAvailable = await NfcManager.instance.isAvailable();
          NfcManager.instance.startSession(
            onDiscovered: (NfcTag tag) async {
              var ndef = Ndef.from(tag);
              if (ndef == null || !ndef.isWritable) {
                NfcManager.instance.stopSession(errorMessage: result.value);
                return;
              }
              NdefMessage messageNama = NdefMessage([
                NdefRecord.createText('NFC ID: $idMHS'),
                NdefRecord.createText('Nama: $namaMahasiswa'),
                NdefRecord.createText('NIM: $nimMahasiswa'),
                // NdefRecord.createUri(Uri.parse(urlDownload))
              ]);
              try {
                await ndef.write(messageNama);
                result.value = 'Success to "Ndef Write"';
                NfcManager.instance.stopSession();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new MahasiswaPage(),
                  ),
                );
              } catch (e) {
                result.value = e;
                NfcManager.instance
                    .stopSession(errorMessage: result.value.toString());
                return;
              }
            },
          );
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(
                "Place student card on NFC Reader/Writer",
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              actions: [
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: kBlackColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigator.push(
                      //   context,
                      //   new MaterialPageRoute(
                      //     builder: (context) => new MahasiswaPage(),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Cancel',
                      style: whiteTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Text(
          'Register Mahasiswa to NFC',
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

    idMHS = docMahasiswa.id;

    final json = mahasiswa.toJson();

    await docMahasiswa.set(json);
  }
}
