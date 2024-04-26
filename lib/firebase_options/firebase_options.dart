import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'web_firebase_options.dart' if (dart.library.html) 'web_firebase_options.dart';
import 'android_firebase_options.dart' if (dart.library.io) 'android_firebase_options.dart';
import 'ios_firebase_options.dart' if (dart.library.io) 'ios_firebase_options.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return webFirebaseOptions;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidFirebaseOptions;
      case TargetPlatform.iOS:
        return iosFirebaseOptions;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
}
