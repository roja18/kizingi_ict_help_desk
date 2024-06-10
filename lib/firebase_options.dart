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
    apiKey: 'AIzaSyBxy7KszqMWTB0ul-CiBGCjt5PZpCIj9u8',
    appId: '1:958965371682:web:384085dbf69e468ced4b7b',
    messagingSenderId: '958965371682',
    projectId: 'icthelpdesk-e864f',
    authDomain: 'icthelpdesk-e864f.firebaseapp.com',
    storageBucket: 'icthelpdesk-e864f.appspot.com',
    measurementId: 'G-2SHLNYQERT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLyv_CcQ19IB6-uZKe2qCPfNcIM329eUg',
    appId: '1:958965371682:android:73f0dc4bc5c0eed9ed4b7b',
    messagingSenderId: '958965371682',
    projectId: 'icthelpdesk-e864f',
    storageBucket: 'icthelpdesk-e864f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYXWWjUg-p1ofMg1LdfSRzCFckzUm9Uqw',
    appId: '1:958965371682:ios:fdda6dea4a4ffaf9ed4b7b',
    messagingSenderId: '958965371682',
    projectId: 'icthelpdesk-e864f',
    storageBucket: 'icthelpdesk-e864f.appspot.com',
    iosBundleId: 'com.example.kizingiIctHelpDeskv3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYXWWjUg-p1ofMg1LdfSRzCFckzUm9Uqw',
    appId: '1:958965371682:ios:fdda6dea4a4ffaf9ed4b7b',
    messagingSenderId: '958965371682',
    projectId: 'icthelpdesk-e864f',
    storageBucket: 'icthelpdesk-e864f.appspot.com',
    iosBundleId: 'com.example.kizingiIctHelpDeskv3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBxy7KszqMWTB0ul-CiBGCjt5PZpCIj9u8',
    appId: '1:958965371682:web:0b4a099ea70c0bc0ed4b7b',
    messagingSenderId: '958965371682',
    projectId: 'icthelpdesk-e864f',
    authDomain: 'icthelpdesk-e864f.firebaseapp.com',
    storageBucket: 'icthelpdesk-e864f.appspot.com',
    measurementId: 'G-YYG2WJ7Q2V',
  );
}