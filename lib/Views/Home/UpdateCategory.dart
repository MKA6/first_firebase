import 'package:first_firedase/admin/models/Category.dart';
import 'package:first_firedase/providers/AdminProvider/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCategory extends StatelessWidget {
  Category category ;
  UpdateCategory(this.category);

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
              ),
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
                      provider.pickCategoryImage();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(500),
                          color: Colors.white
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: provider.pickedImage == null
                          ? Icon(Icons.camera_alt)
                          : Image.file(provider.pickedImage! ,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: provider.catNameController,
                      validator: (String? x) {
                        if (x == null || x.isEmpty ) {
                          return "The value is empty";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Update Category",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(500),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      bool isValid = formKey.currentState!.validate();
                      if (isValid) {
                        provider.CreatNewCategory();
                        // Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      provider.getAllCategory();
                    },
                    child: const Text(
                      'Test',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
