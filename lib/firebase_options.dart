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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA5GbjvjW7-QvQvAlpQLEDGI9anvhhlyFg',
    appId: '1:227839041176:web:a4abf667e36a81f9a0faed',
    messagingSenderId: '227839041176',
    projectId: 'labor-3328a',
    authDomain: 'labor-3328a.firebaseapp.com',
    storageBucket: 'labor-3328a.appspot.com',
    measurementId: 'G-FQN816GP4J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALKmoHdUpldnLXi5Sx3qBhgObz0p0KIfk',
    appId: '1:227839041176:android:5a8c1f09e3a46db2a0faed',
    messagingSenderId: '227839041176',
    projectId: 'labor-3328a',
    storageBucket: 'labor-3328a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5cWsnUH81-hQl2S-Gg29h2f6qJ0AVW8k',
    appId: '1:227839041176:ios:7172f066a05daa3da0faed',
    messagingSenderId: '227839041176',
    projectId: 'labor-3328a',
    storageBucket: 'labor-3328a.appspot.com',
    iosClientId: '227839041176-0mqumqbmdujnp7uachu8lqr0kln7kjgb.apps.googleusercontent.com',
    iosBundleId: 'com.example.labour',
  );
}
