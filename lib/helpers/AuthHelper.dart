import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firedase/AppRouter/AppRouter.dart';

class AuthHelper {
  AuthHelper._mohammed();

  static AuthHelper authHelper = AuthHelper._mohammed();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> login(String email, String password) async {
    try {
      // log(email);
      // log(password);
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppRouter.shoeCustomDiaoug('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        AppRouter.shoeCustomDiaoug('Wrong password provided for that user.');
      } else {
        AppRouter.shoeCustomDiaoug(e.toString());
      }
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //AppRouter.shoeCustomDiaoug('The account has been created successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppRouter.shoeCustomDiaoug('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        AppRouter.shoeCustomDiaoug(
            'The account already exists for that email.');
      } else {
        AppRouter.shoeCustomDiaoug(e.toString());
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  User? checkUser() {
    return firebaseAuth.currentUser;
  }
}
