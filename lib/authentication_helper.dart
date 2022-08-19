// ignore_for_file: unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({
    required String email,
    required String password,
  }) async {
    if (password.length >= 6) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return null;
      } on FirebaseAuthException catch (e) {
        return e.message;
      }
    } else {
      print('Password Must Be atleast 6 Character!');
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}