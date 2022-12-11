import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_firedase/Models/AppUser.dart';
import 'package:first_firedase/admin/models/Category.dart';
import 'package:first_firedase/admin/models/produacts.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  createNewUser(AppUser appUser) async {
    firebaseFirestore.collection('users').doc(appUser.id).set(appUser.toMap());
  }

  Future<AppUser> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await firebaseFirestore.collection('users').doc(id).get();
    Map<String, dynamic>? data = document.data();
    // log(data.toString());
    AppUser appUser = AppUser.fromMap(data!);
    return appUser;
  }

  updateUserInfo(AppUser appUser) async {
    await firebaseFirestore
        .collection('users')
        .doc(appUser.id)
        .update(appUser.toMap());
  }

  ///  admin functions

  Future<String> createNewCategory(Category category) async {
    DocumentReference<Map<String, dynamic>> document =
        await firebaseFirestore.collection('categories').add(category.toMap());
    return document.id;
  }

  Future<List<Category>> getAllCategory() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('categories').get();
    List<Category> category = querySnapshot.docs.map((e) {
      Category cat = Category.fromMap(e.data());
      cat.id = e.id;
      return cat;
    }).toList();
    // log(category.length.toString());
    return category;
  }

  deleteNewCategory(String id) async {
    await firebaseFirestore.collection('categories').doc(id).delete();
  }

  ///  /// /// ////////////////////////////////////////////////
  updateNewCategory(Category category) {}

  Future<String> AddNewProduacts(Produacts produacts) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await firebaseFirestore
            .collection('categories')
            .doc(produacts.catId)
            .collection('produacts')
            .add(produacts.toMap());
    return documentReference.id;
  }

  Future<List<Produacts>?> getAllProduacts(String catId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
          .collection('categories')
          .doc(catId)
          .collection('produacts')
          .get();
      
      return querySnapshot.docs.map((e) {
        Produacts produacts = Produacts.fromMap(e.data());
        produacts.id = e.id;
        return produacts;
      }).toList();
    } on Exception catch (e) {
      // TODO
    }
  }
}
