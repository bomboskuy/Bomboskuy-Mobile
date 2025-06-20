// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCINHr3IZ-p3DLVcn27V5yORUf6K_7y3B8',
    appId: '1:410039092871:web:73b08073c6279d00be1a22',
    messagingSenderId: '410039092871',
    projectId: 'bomboskuy-firebase',
    authDomain: 'bomboskuy-firebase.firebaseapp.com',
    storageBucket: 'bomboskuy-firebase.firebasestorage.app',
    measurementId: 'G-9D8QEVNVXY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqAv0Nji6c_BMFMBilEJvQiHwnSTu_qaE',
    appId: '1:410039092871:android:0c7dc4c05fa59205be1a22',
    messagingSenderId: '410039092871',
    projectId: 'bomboskuy-firebase',
    storageBucket: 'bomboskuy-firebase.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSrThFFOmBN5OZBrdZ4-zZ8UjsqOSkev8',
    appId: '1:410039092871:ios:ea03fb85718d4aaabe1a22',
    messagingSenderId: '410039092871',
    projectId: 'bomboskuy-firebase',
    storageBucket: 'bomboskuy-firebase.firebasestorage.app',
    iosBundleId: 'com.example.bomboskuy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSrThFFOmBN5OZBrdZ4-zZ8UjsqOSkev8',
    appId: '1:410039092871:ios:ea03fb85718d4aaabe1a22',
    messagingSenderId: '410039092871',
    projectId: 'bomboskuy-firebase',
    storageBucket: 'bomboskuy-firebase.firebasestorage.app',
    iosBundleId: 'com.example.bomboskuy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCINHr3IZ-p3DLVcn27V5yORUf6K_7y3B8',
    appId: '1:410039092871:web:b373451eef1453ecbe1a22',
    messagingSenderId: '410039092871',
    projectId: 'bomboskuy-firebase',
    authDomain: 'bomboskuy-firebase.firebaseapp.com',
    storageBucket: 'bomboskuy-firebase.firebasestorage.app',
    measurementId: 'G-3J34GNFQ0X',
  );
}
