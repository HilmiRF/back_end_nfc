// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:back_end_nfc/models/dosen.dart';
import 'package:back_end_nfc/screens/add_dosen.dart';
import 'package:back_end_nfc/screens/update_dosen.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';

class DosenPage extends StatefulWidget {
  const DosenPage({Key? key}) : super(key: key);

  @override
  State<DosenPage> createState() => _DosenPageState();
}

class _DosenPageState extends State<DosenPage> {
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
                  builder: (context) => new AddDosen(),
                ),
              );
            }),
        appBar: AppBar(
          backgroundColor: kBlackColor,
          title: Text(
            'Master Dosen',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
        drawer: NavigationDrawer(),
        body: StreamBuilder<List<Dosen>>(
            stream: readDosen(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something Went Wrong!');
              } else if (snapshot.hasData) {
                final dosen = snapshot.data!;
                return ListView(
                  children: dosen.map(buildDosen).toList(),
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

  Widget buildDosen(Dosen dosen) => Container(
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
                dosen.namaDosen,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              subtitle: Text(
                'NIP: ${dosen.nipDosen}',
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
                          builder: (context) => UpdateDosen(
                            nama: dosen.namaDosen,
                            nip: dosen.nipDosen,
                            id: dosen.id,
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
                                  final docDosen = FirebaseFirestore.instance
                                      .collection('dosen')
                                      .doc(dosen.id);

                                  docDosen.delete();
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

  Stream<List<Dosen>> readDosen() => FirebaseFirestore.instance
      .collection('dosen')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Dosen.fromJson(doc.data())).toList());
}
