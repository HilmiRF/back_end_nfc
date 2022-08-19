// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:back_end_nfc/models/mahasiswa.dart';
import 'package:back_end_nfc/models/matkul.dart';
import 'package:back_end_nfc/screens/add_mahasiswa.dart';
import 'package:back_end_nfc/screens/update_mahasiswa.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';

class MahasiswaPage extends StatefulWidget {
  const MahasiswaPage({Key? key}) : super(key: key);

  @override
  State<MahasiswaPage> createState() => _MahasiswaPageState();
}

class _MahasiswaPageState extends State<MahasiswaPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Back End Presensi NFC',
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: kBlackColor,
            child: Icon(Icons.add_outlined),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new AddMahasiswa(),
                ),
              );
            }),
        appBar: AppBar(
          backgroundColor: kBlackColor,
          title: Text(
            'Master Mahasiswa',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
        drawer: NavigationDrawer(),
        body: StreamBuilder<List<Mahasiswa>>(
            stream: readMahasiswa(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something Went Wrong!');
              } else if (snapshot.hasData) {
                final mahasiswa = snapshot.data!;
                return ListView(
                  children: mahasiswa.map(buildMahasiswa).toList(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget buildMahasiswa(Mahasiswa mahasiswa) => Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: kLineDarkColor,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                mahasiswa.namaMahasiswa,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              subtitle: Text(
                'NIM: ${mahasiswa.nimMahasiswa}',
                style: greyTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: regular,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kBlackColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateMahasiswa(
                            nama: mahasiswa.namaMahasiswa,
                            nim: mahasiswa.nimMahasiswa,
                            id: mahasiswa.id,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Update',
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kBlackColor,
                  ),
                  child: TextButton(
                    onPressed: () {
                      final docMahasiswa = FirebaseFirestore.instance
                          .collection('mahasiswa')
                          .doc(mahasiswa.id);

                      docMahasiswa.delete();
                    },
                    child: Text(
                      'Delete',
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Stream<List<Mahasiswa>> readMahasiswa() => FirebaseFirestore.instance
      .collection('mahasiswa')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Mahasiswa.fromJson(doc.data())).toList());
}
