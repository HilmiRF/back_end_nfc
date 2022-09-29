// ignore_for_file: prefer_const_constructors, unnecessary_new, use_build_context_synchronously

import 'package:back_end_nfc/screens/mahasiswa_view.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class UpdateMahasiswa extends StatefulWidget {
  final String nama;
  final String nim;
  final String id;
  const UpdateMahasiswa(
      {Key? key, required this.nama, required this.nim, required this.id})
      : super(key: key);

  @override
  State<UpdateMahasiswa> createState() => _UpdateMahasiswaState();
}

class _UpdateMahasiswaState extends State<UpdateMahasiswa> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  late TextEditingController namaMahasiswaController =
      TextEditingController(text: widget.nama);
  late TextEditingController nimMahasiswaController =
      TextEditingController(text: widget.nim);
  late String idMHS = widget.id;
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
            updateMahasiswa(),
            registerNFC()
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
            'Update Mahasiswa',
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
      ],
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

  Widget updateMahasiswa() {
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
          final docMahasiswa =
              FirebaseFirestore.instance.collection('mahasiswa').doc(widget.id);
          docMahasiswa.update({
            'nama_mahasiswa': namaMahasiswa,
            'nim_mahasiswa': nimMahasiswa,
          });
          // Navigator.push(
          //   context,
          //   new MaterialPageRoute(
          //     builder: (context) => new MahasiswaPage(),
          //   ),
          // );
          // add code above
        },
        child: Text(
          'Update Mahasiswa',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }
}
