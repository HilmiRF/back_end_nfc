// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:back_end_nfc/models/matkul.dart';
import 'package:back_end_nfc/screens/add_matkul.dart';
import 'package:back_end_nfc/screens/update_matkul.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import '../widgets/navigation_drawer.dart';

class MatkulPage extends StatefulWidget {
  const MatkulPage({Key? key}) : super(key: key);

  @override
  State<MatkulPage> createState() => _MatkulPageState();
}

class _MatkulPageState extends State<MatkulPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kBlackColor,
          child: Icon(Icons.add_outlined),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new AddMatkul(),
              ),
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: kBlackColor,
          title: Text(
            'Master Mata kuliah',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
        drawer: NavigationDrawer(),
        body: StreamBuilder<List<Matkul>>(
            stream: readMatkul(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something Went Wrong!');
              } else if (snapshot.hasData) {
                final matkul = snapshot.data!;
                return ListView(
                  children: matkul.map(buildMatkul).toList(),
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

  Widget buildMatkul(Matkul matkul) => Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: kLineDarkColor,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                matkul.namaMatkul,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              subtitle: Text(
                'Kode Kelas: ${matkul.kodeMatkul}, SKS Kelas: ${matkul.sksMatkul}',
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
                          builder: (context) => UpdateMatkul(
                            id: matkul.id,
                            kode: matkul.kodeMatkul,
                            nama: matkul.namaMatkul,
                            sks: matkul.sksMatkul,
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
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(
                            "Are You Sure You Want to Delete the Data?",
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
                              // width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: kBlackColor,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(_).pop();
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
                            Container(
                              // width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: kBlackColor,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final docMatkul = FirebaseFirestore.instance
                                      .collection('matkul')
                                      .doc(matkul.id);

                                  docMatkul.delete();
                                  Navigator.of(_).pop();
                                },
                                child: Text(
                                  'Delete',
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

  Stream<List<Matkul>> readMatkul() => FirebaseFirestore.instance
      .collection('matkul')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Matkul.fromJson(doc.data())).toList());

  // Widget tabelMatkul() {
  //   var kelas = FirebaseFirestore.instance.collection('matkul').snapshots();
  //   return Container();
  // }

  // Widget addMatkul() {
  //   // Submit Created Class ke Firebase
  //   return ;
  // }
}
