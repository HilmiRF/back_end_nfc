// ignore_for_file: prefer_const_constructors

import 'package:back_end_nfc/screens/dosen_view.dart';
import 'package:back_end_nfc/screens/mahasiswa_view.dart';
import 'package:back_end_nfc/screens/matkul_view.dart';
import 'package:back_end_nfc/themes.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: kBlackColor,
            ),
            title: Text(
              'Dosen',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => DosenPage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.book_outlined,
              color: kBlackColor,
            ),
            title: Text(
              'Mata Kuliah',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MatkulPage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.workspaces_outlined,
              color: kBlackColor,
            ),
            title: Text(
              'Mahasiswa',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MahasiswaPage()));
            },
          ),
        ],
      ),
    );
  }
}
