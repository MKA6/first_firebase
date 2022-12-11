import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firedase/AppRouter/AppRouter.dart';
import 'package:first_firedase/Models/AppUser.dart';
import 'package:first_firedase/Views/Auth/Screens/LoginScreen.dart';
import 'package:first_firedase/Views/Auth/Screens/RegisterScreen.dart';
import 'package:first_firedase/Views/Home/AddNewCategory.dart';
import 'package:first_firedase/Views/Home/Category1.dart';
import 'package:first_firedase/Views/Home/DisplayAllCategories.dart';
import 'package:first_firedase/Views/Home/HomeScreen.dart';
import 'package:first_firedase/admin/models/Category.dart';
import 'package:first_firedase/helpers/AuthHelper.dart';
import 'package:first_firedase/helpers/FirestoreHelper.dart';
import 'package:first_firedase/helpers/StoragHelper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    checkUser();
  }

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerfNameController = TextEditingController();
  TextEditingController registerlNameController = TextEditingController();
  TextEditingController registerPhoneNumberController = TextEditingController();

  TextEditingController profilePhoneController = TextEditingController();
  TextEditingController profileUserNameController = TextEditingController();
  TextEditingController profileEmailController = TextEditingController();

  AppUser? loggedAppUser;

  late User loggedUser;

  login() async {
    String? userId = await AuthHelper.authHelper.login(
        loginEmailController.text.trim(),
        loginPasswordController
            .text); // المشكلة كانت انه ما كنت باعت اله هين بيانات
    if (userId != null) {
      getUserFromFirestore(userId);
      //  log(userId.toString());
      AppRouter.navigateAndReplaceScreen(HomeScreen());
      notifyListeners();
    }
  }

  getUserFromFirestore(String id) async {
    loggedAppUser = await FirestoreHelper.firestoreHelper
        .getUserFromFirestore(id); // "nlGEiWdwPbCuNTHMPWch"
    loggedAppUser!.id = id;
    profileUserNameController.text = loggedAppUser!.fName! ??'';
    profilePhoneController.text = loggedAppUser!.phoneNumber! ??'';
    profileEmailController.text = loggedAppUser!.email! ??'';
    notifyListeners();
  }

  register() async {
    bool isSuccess = await AuthHelper.authHelper.register(
        registerEmailController.text.trim(), registerPasswordController.text);
    getUserFromAuth();
    if (isSuccess) {
      // log('registration success');
      //   AppRouter.navigateAndReplaceScreen(HomeScreen());
      getUserFromAuth();
      AppUser appUser = AppUser(
        loggedUser.uid,
        loggedUser.email,
        registerfNameController.text,
        registerlNameController.text,
        registerPhoneNumberController.text,
      );
      FirestoreHelper.firestoreHelper.createNewUser(appUser);
      AppRouter.navigateAndReplaceScreen(HomeScreen());
    }
  }

  getUserFromAuth() {
    loggedUser = AuthHelper.authHelper.checkUser()!;
  }

  checkUser() async {
    await Future.delayed(Duration(seconds: 3));
    User? user = AuthHelper.authHelper.checkUser();
    if (user == null) {
      /// navigation to auth screen
      AppRouter.navigateAndReplaceScreen(RegisterScreen());
    } else {
      /// navigation to main screen
      getUserFromFirestore(user.uid);
      AppRouter.navigateAndReplaceScreen(DisplayAllCategories());
    }
  }

  signOut() {
    AuthHelper.authHelper.signout();
    AppRouter.navigateAndReplaceScreen(LoginScreen());
  }

  updateUserImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String imageUrl = await StoragHelper.storagHelper.uploadImage("prifile_images", file);
      AppRouter.shoeCustomDiaoug('The image has been uploaded successfully');
      loggedAppUser!.imagUrl = imageUrl;
      await FirestoreHelper.firestoreHelper
          .updateUserInfo(loggedAppUser!);
      getUserFromFirestore(loggedAppUser!.id!);
      // او نستخدم هاد لعرض الصورة
      // loggedAppUser!.imagUrl = imageUrl!;
      // notifyListeners();
    }
  }
  updateUserInfo()async{
    loggedAppUser!.fName = profileUserNameController.text;
    loggedAppUser!.phoneNumber = profilePhoneController.text;
    FirestoreHelper.firestoreHelper.updateUserInfo(loggedAppUser!);
    getUserFromFirestore(loggedAppUser!.id!);
  }
}
