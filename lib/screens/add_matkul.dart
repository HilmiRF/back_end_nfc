// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:back_end_nfc/screens/matkul_view.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/matkul.dart';

class AddMatkul extends StatefulWidget {
  const AddMatkul({Key? key}) : super(key: key);

  @override
  State<AddMatkul> createState() => _AddMatkulState();
}

class _AddMatkulState extends State<AddMatkul> {
  final TextEditingController namaMatkulController = TextEditingController();
  final TextEditingController kodeMatkulController = TextEditingController();
  final TextEditingController sksMatkulController = TextEditingController();
  final TextEditingController hariMatkulController = TextEditingController();
  final TextEditingController waktuMulaiMatkulController =
      TextEditingController();
  final TextEditingController waktuSelesaiMatkulController =
      TextEditingController();
  final TextEditingController ruangMatkulController = TextEditingController();
  final TextEditingController jumlahPesertaController = TextEditingController();
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
            addClass(),
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
            'Tambah Mata Kuliah',
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
        // Field Nama Mata Kuliah
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
            controller: namaMatkulController,
            decoration: InputDecoration.collapsed(
              hintText: 'Nama Mata Kuliah',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Nama Mata Kuliah';
              }
              return null;
            },
          ),
        ),
        // Field Kode Mata Kuliah
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
            controller: kodeMatkulController,
            decoration: InputDecoration.collapsed(
              hintText: 'Kode Mata Kuliah',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Kode Mata Kuliah';
              }
              return null;
            },
          ),
        ),
        // Field SKS Mata Kuliah
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
            controller: sksMatkulController,
            decoration: InputDecoration.collapsed(
              hintText: 'SKS Mata Kuliah',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'SKS Mata Kuliah';
              }
              return null;
            },
          ),
        ),
        // Field Hari Mata Kuliah
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
            controller: hariMatkulController,
            decoration: InputDecoration.collapsed(
              hintText: 'Hari Mata Kuliah',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Hari Mata Kuliah';
              }
              return null;
            },
          ),
        ),
        // Field Waktu Mulai Mata Kuliah
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
            controller: waktuMulaiMatkulController,
            decoration: InputDecoration.collapsed(
              hintText: 'Waktu Mulai Mata Kuliah',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Waktu Mulai Mata Kuliah';
              }
              return null;
            },
          ),
        ),
        // Field Waktu Mulai Mata Kuliah
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
            controller: waktuSelesaiMatkulController,
            decoration: InputDecoration.collapsed(
              hintText: 'Waktu Selesai Mata Kuliah',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Waktu Selesai Mata Kuliah';
              }
              return null;
            },
          ),
        ),
        // Field Ruang Mata Kuliah
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
            controller: ruangMatkulController,
            decoration: InputDecoration.collapsed(
              hintText: 'Ruang Mata Kuliah',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ruang Mata Kuliah';
              }
              return null;
            },
          ),
        ),
        // Field Jumlah Peserta MA
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
            controller: jumlahPesertaController,
            decoration: InputDecoration.collapsed(
              hintText: 'Jumlah Peserta Mata Kuliah',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Jumlah Peserta Kuliah';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget addClass() {
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
          final namaMatkul = namaMatkulController.text;
          final waktuSelesaiMatkul = waktuSelesaiMatkulController.text;
          final waktuMulaiMatkul = waktuMulaiMatkulController.text;
          final hariMatkul = hariMatkulController.text;
          final jumlahMHS = jumlahPesertaController.text;
          final kodeMatkul = kodeMatkulController.text;
          final ruangMatkul = ruangMatkulController.text;
          final sksMatkul = sksMatkulController.text;
          createMatkul(
            namaMatkul: namaMatkul,
            waktuSelesaiMatkul: waktuSelesaiMatkul,
            hariMatkul: hariMatkul,
            jumlahMHS: jumlahMHS,
            kodeMatkul: kodeMatkul,
            ruangMatkul: ruangMatkul,
            sksMatkul: sksMatkul,
            waktuMulaiMatkul: waktuMulaiMatkul,
          );
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new MatkulPage(),
            ),
          );
          // add code above
        },
        child: Text(
          'Create Class',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }

  Future createMatkul(
      {required String namaMatkul,
      required String kodeMatkul,
      required String sksMatkul,
      required String hariMatkul,
      required String waktuMulaiMatkul,
      required String waktuSelesaiMatkul,
      required String ruangMatkul,
      required String jumlahMHS}) async {
    final docMatkul = FirebaseFirestore.instance.collection('matkul').doc();

    final matkul = Matkul(
      namaMatkul: namaMatkul,
      kodeMatkul: kodeMatkul,
      sksMatkul: sksMatkul,
      hariMatkul: hariMatkul,
      waktuMulaiMatkul: waktuMulaiMatkul,
      waktuSelesaiMatkul: waktuSelesaiMatkul,
      ruangMatkul: ruangMatkul,
      jumlahMHS: jumlahMHS,
      id: docMatkul.id,
    );

    final json = matkul.toJson();

    await docMatkul.set(json);
  }
}
