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
    apiKey: 'AIzaSyAAlcXpNThRAsS83l92gpHiLKYA0w9uBCo',
    appId: '1:138074167600:web:86db6e326b82361d95d0f5',
    messagingSenderId: '138074167600',
    projectId: 'schatbook-8a073',
    authDomain: 'schatbook-8a073.firebaseapp.com',
    storageBucket: 'schatbook-8a073.appspot.com',
    measurementId: 'G-CH190J7CNT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGkXYg72LEcabeCUwiWtE6zidHEGQmkjo',
    appId: '1:138074167600:android:19ec31a7da427bd695d0f5',
    messagingSenderId: '138074167600',
    projectId: 'schatbook-8a073',
    storageBucket: 'schatbook-8a073.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3W38CT1QCqJlw_MN8WC6_VsR5PWM0hBw',
    appId: '1:138074167600:ios:fb4b0d524e9eaa7c95d0f5',
    messagingSenderId: '138074167600',
    projectId: 'schatbook-8a073',
    storageBucket: 'schatbook-8a073.appspot.com',
    iosBundleId: 'com.example.schatbooks',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3W38CT1QCqJlw_MN8WC6_VsR5PWM0hBw',
    appId: '1:138074167600:ios:78d4c88895f2a60495d0f5',
    messagingSenderId: '138074167600',
    projectId: 'schatbook-8a073',
    storageBucket: 'schatbook-8a073.appspot.com',
    iosBundleId: 'com.example.schatbooks.RunnerTests',
  );
}