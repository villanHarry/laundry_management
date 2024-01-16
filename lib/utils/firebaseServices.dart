import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth? auth = FirebaseAuth.instance;

class FirebaseServices {
  static Future<bool> login(String username, String password) async {
    UserCredential? user;
    user = await auth!
        .signInWithEmailAndPassword(email: username, password: password);
    if (user != null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> signup(String username, String password) async {
    UserCredential? user = await auth!
        .createUserWithEmailAndPassword(email: username, password: password);
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }
}
