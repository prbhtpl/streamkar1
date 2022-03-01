import 'package:firebase_auth/firebase_auth.dart';

import '../helper/helperFunctions.dart';
import '../modal/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(UserId: user.uid) : null;

  }

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
    }
  }

  Future SignUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }

  }
  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }
  Future SignOut() async {

    try {
     await HelperFunctions.saveuserLoggedInSharedPreference(false);
      print("result  : ${HelperFunctions.getuserLoggedInSharedPreference()}");
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
