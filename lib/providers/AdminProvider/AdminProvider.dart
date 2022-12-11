import 'dart:io';

import 'package:first_firedase/AppRouter/AppRouter.dart';
import 'package:first_firedase/admin/models/Category.dart';
import 'package:first_firedase/admin/models/produacts.dart';
import 'package:first_firedase/helpers/FirestoreHelper.dart';
import 'package:first_firedase/helpers/StoragHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    getAllCategory();
  }

  TextEditingController catNameController = TextEditingController();
  File? pickedImage;
  List<Category>? categories;
  List<Produacts>? produact;

  pickCategoryImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      pickedImage = File(xFile.path);
      notifyListeners();
    }
  }

  CreatNewCategory() async {
    if (pickedImage != null) {
      AppRouter.showLoaderDialog();
      String imageUrl = await StoragHelper.storagHelper
          .uploadImage("Category_Images", pickedImage!);
      Category category =
          Category(name: catNameController.text, image: imageUrl);

      String id =
          await FirestoreHelper.firestoreHelper.createNewCategory(category);
      category.id = id;
      categories!.add(category);

      pickedImage == null;
      catNameController.clear();
      notifyListeners();
      AppRouter.hideLoadingDialoug();
      AppRouter.shoeCustomDiaoug("The category has been successfully");
    }
    // }else{
    //   AppRouter.shoeCustomDiaoug("Yoe have to select image first");
    // }
  }

  getAllCategory() async {
    categories = await FirestoreHelper.firestoreHelper.getAllCategory();
    notifyListeners();
  }

  deleteCategory(Category category) async {
    AppRouter.showLoaderDialog();
    await FirestoreHelper.firestoreHelper.deleteNewCategory(category.id!);
    AppRouter.hideLoadingDialoug();
    // AppRouter.shoeCustomDiaoug('The delete has been successfully');
    categories!.remove(category);
    notifyListeners();
  }

  /// ////////////
  /// كمل عليها
  updateCategory(Category category) async {
    AppRouter.showLoaderDialog();
    await FirestoreHelper.firestoreHelper.deleteNewCategory(category.id!);
    AppRouter.hideLoadingDialoug();
    // categories!.
    notifyListeners();
  }

  /// //// //////////////////////////////////////

  TextEditingController produactsNameController = TextEditingController();
  TextEditingController produactsDescriptionController =
      TextEditingController();
  TextEditingController produactsPriceController = TextEditingController();

  addProduacts(String catId) async {
    if (pickedImage != null) {
      AppRouter.showLoaderDialog();
      String imageUrl = await StoragHelper.storagHelper
          .uploadImage("Produacts_Images", pickedImage!);
      Produacts produacts = Produacts(
        name: produactsNameController.text,
        imageUrl: imageUrl,
        description: produactsDescriptionController.text,
        price: produactsPriceController.text,
        catId: catId,
      );

      String id =
          await FirestoreHelper.firestoreHelper.AddNewProduacts(produacts);
      produacts.id = id;
      produact?.add(produacts);
      pickedImage == null;
      produactsNameController.clear();
      produactsDescriptionController.clear();
      produactsPriceController.clear();
      notifyListeners();
      AppRouter.hideLoadingDialoug();
      AppRouter.shoeCustomDiaoug("The category has been successfully");
    }
  }
  
  getAllProduacts(String catId)async{
   // AppRouter.showLoaderDialog();
    produact = await FirestoreHelper.firestoreHelper.getAllProduacts(catId);
    notifyListeners();
   // AppRouter.hideLoadingDialoug();
  }
}
