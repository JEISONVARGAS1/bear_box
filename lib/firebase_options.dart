import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB3iy1TNQVnJF2XNz8rdk-8sTVcb-IEoUg',
    appId: '1:916249800764:web:60b68e6b3b005a84005339',
    messagingSenderId: '916249800764',
    projectId: 'bearbox-d0112',
    authDomain: 'bearbox-d0112.firebaseapp.com',
    storageBucket: 'bearbox-d0112.firebasestorage.app',
    measurementId: 'G-VE3PC1511M',
  );
} 