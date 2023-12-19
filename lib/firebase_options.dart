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
    apiKey: 'AIzaSyAr4mjAfcEB4LjAUN9dvT9-L9nEJT_Ql98',
    appId: '1:418893390894:web:3231378a32aa76794c6bbf',
    messagingSenderId: '418893390894',
    projectId: 'nvision-c00ea',
    authDomain: 'nvision-c00ea.firebaseapp.com',
    storageBucket: 'nvision-c00ea.appspot.com',
    measurementId: 'G-8RQ64BXEZY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbPMW_uQlD-5inkWVcMAqXet1viKRnWAw',
    appId: '1:418893390894:android:2502754708f1a6304c6bbf',
    messagingSenderId: '418893390894',
    projectId: 'nvision-c00ea',
    storageBucket: 'nvision-c00ea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbklBVfDzpRL1JNoStmCpBjNKWxyYdmLs',
    appId: '1:418893390894:ios:fd54b28b45ddfa934c6bbf',
    messagingSenderId: '418893390894',
    projectId: 'nvision-c00ea',
    storageBucket: 'nvision-c00ea.appspot.com',
    iosClientId: '418893390894-8bhb183nld3aiaoel2chn5e9i1338ia5.apps.googleusercontent.com',
    iosBundleId: 'com.example.nVision',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbklBVfDzpRL1JNoStmCpBjNKWxyYdmLs',
    appId: '1:418893390894:ios:c1cade2525114c714c6bbf',
    messagingSenderId: '418893390894',
    projectId: 'nvision-c00ea',
    storageBucket: 'nvision-c00ea.appspot.com',
    iosClientId: '418893390894-85a520ol36784v9euf485ndru3acj92q.apps.googleusercontent.com',
    iosBundleId: 'com.example.nVision.RunnerTests',
  );
}
