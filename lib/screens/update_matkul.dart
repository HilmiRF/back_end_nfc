// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:back_end_nfc/screens/matkul_view.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateMatkul extends StatefulWidget {
  final String nama;
  final String sks;
  final String kode;
  final String hari;
  final String mulai;
  final String selesai;
  final String jumlah;
  final String ruang;
  final String id;
  const UpdateMatkul(
      {Key? key,
      required this.nama,
      required this.sks,
      required this.kode,
      required this.hari,
      required this.mulai,
      required this.selesai,
      required this.jumlah,
      required this.ruang,
      required this.id})
      : super(key: key);

  @override
  State<UpdateMatkul> createState() => _UpdateMatkulState();
}

class _UpdateMatkulState extends State<UpdateMatkul> {
  late TextEditingController namaMatkulController =
      TextEditingController(text: widget.nama);
  late TextEditingController kodeMatkulController =
      TextEditingController(text: widget.kode);
  late TextEditingController sksMatkulController =
      TextEditingController(text: widget.sks);
  late TextEditingController hariMatkulController =
      TextEditingController(text: widget.hari);
  late TextEditingController waktuMulaiMatkulController =
      TextEditingController(text: widget.mulai);
  late TextEditingController waktuSelesaiMatkulController =
      TextEditingController(text: widget.selesai);
  late TextEditingController ruangMatkulController =
      TextEditingController(text: widget.ruang);
  late TextEditingController jumlahPesertaController =
      TextEditingController(text: widget.jumlah);
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
            updateMatkul(),
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
            'Update Mata Kuliah',
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

  Widget updateMatkul() {
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
          final docMatkul =
              FirebaseFirestore.instance.collection('matkul').doc(widget.id);
          docMatkul.update({
            'nama_kelas': namaMatkul,
            'kode_kelas': kodeMatkul,
            'sks_kelas': sksMatkul,
            'hari_kelas': hariMatkul,
            'waktu_kelas_mulai': waktuMulaiMatkul,
            'waktu_kelas_selesai': waktuSelesaiMatkul,
            'ruang_kelas': ruangMatkul,
            'jumlah_mhs': jumlahMHS,
            'id': docMatkul.id,
          });
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new MatkulPage(),
            ),
          );
          // add code above
        },
        child: Text(
          'Update Mata Kuliah',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }
}