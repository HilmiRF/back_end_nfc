// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB61Nbbr1tfSBRPfjC1XOSu2bjEVQms0hM',
    appId: '1:311234347031:web:ffbc763156c78ba00e1c52',
    messagingSenderId: '311234347031',
    projectId: 'aplikasi-presensi-bf763',
    authDomain: 'aplikasi-presensi-bf763.firebaseapp.com',
    storageBucket: 'aplikasi-presensi-bf763.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAol9XWDMGoIVUGY3PCmruH_Ihmj8Q0EZ4',
    appId: '1:311234347031:android:d6494ccb9c6ec8d80e1c52',
    messagingSenderId: '311234347031',
    projectId: 'aplikasi-presensi-bf763',
    storageBucket: 'aplikasi-presensi-bf763.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALeZ_zSiRc-bzp4WTZRlLVsdG7Lp3-c70',
    appId: '1:311234347031:ios:6ee15aeb73b9da660e1c52',
    messagingSenderId: '311234347031',
    projectId: 'aplikasi-presensi-bf763',
    storageBucket: 'aplikasi-presensi-bf763.appspot.com',
    iosClientId: '311234347031-rjbhv7el286368v61lo34ih2g7c1n3af.apps.googleusercontent.com',
    iosBundleId: 'com.example.backEndNfc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyALeZ_zSiRc-bzp4WTZRlLVsdG7Lp3-c70',
    appId: '1:311234347031:ios:6ee15aeb73b9da660e1c52',
    messagingSenderId: '311234347031',
    projectId: 'aplikasi-presensi-bf763',
    storageBucket: 'aplikasi-presensi-bf763.appspot.com',
    iosClientId: '311234347031-rjbhv7el286368v61lo34ih2g7c1n3af.apps.googleusercontent.com',
    iosBundleId: 'com.example.backEndNfc',
  );
}