import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_firedase/Views/Auth/Widgets/Custom_Profile_Item.dart';
import 'package:first_firedase/admin/models/Category.dart';
import 'package:first_firedase/helpers/FirestoreHelper.dart';
import 'package:first_firedase/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, _) {
        return provider.loggedAppUser == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .signOut();
                          provider.loginEmailController.clear();
                          provider.loginPasswordController.clear();
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                        )),
                  ],
                ),
                backgroundColor: Colors.blue,
                body: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            provider.updateUserImage();
                          },
                          child: provider.loggedAppUser!.imagUrl == null
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(500)
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: provider.loggedAppUser!.imagUrl == null
                                      ? Icon(Icons.camera_alt)
                                      : Image.network(
                                          provider.loggedAppUser!.imagUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomProfileItem(
                          "Full Name : ",
                          (provider.loggedAppUser!.fName! +
                              " " +
                              provider.loggedAppUser!.lName!),
                          provider.profileUserNameController,
                        ),
                        CustomProfileItem(
                          "Phone Number : ",
                          provider.loggedAppUser!.phoneNumber!,
                          provider.profilePhoneController,
                        ),
                        CustomProfileItem(
                          "email : ",
                          provider.loggedAppUser!.email!,
                          provider.profileEmailController,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            bool isValid = formKey.currentState!.validate();
                            if(isValid) {
                              provider.updateUserInfo();
                            }
                          },
                          child:const Text(
                            'Upload',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Category catrgory = Category(name: "mohammed" , image: "image");
                            FirestoreHelper.firestoreHelper.createNewCategory(catrgory);
                          },
                          child:const Text(
                            'Test',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
