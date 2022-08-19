// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:back_end_nfc/models/dosen.dart';
import 'package:back_end_nfc/screens/dosen_view.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDosen extends StatefulWidget {
  final String nama;
  final String nip;
  final String id;
  const UpdateDosen(
      {Key? key, required this.nama, required this.nip, required this.id})
      : super(key: key);

  @override
  State<UpdateDosen> createState() => _UpdateDosenState();
}

class _UpdateDosenState extends State<UpdateDosen> {
  late TextEditingController namaDosenController =
      TextEditingController(text: widget.nama);
  late TextEditingController nipDosenController =
      TextEditingController(text: widget.nip);

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
            updateDosen(),
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
            'Update Dosen',
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
      ],
    );
  }

  Widget updateDosen() {
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
          final namaDosen = namaDosenController.text;
          final nipDosen = nipDosenController.text;
          final docDosen =
              FirebaseFirestore.instance.collection('dosen').doc(widget.id);
          docDosen.update({
            'nama_dosen': namaDosen,
            'nip_dosen': nipDosen,
          });
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new DosenPage(),
            ),
          );
          // add code above
        },
        child: Text(
          'Update Dosen',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }

  Stream<List<Dosen>> readDosen() => FirebaseFirestore.instance
      .collection('dosen')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Dosen.fromJson(doc.data())).toList());
}
