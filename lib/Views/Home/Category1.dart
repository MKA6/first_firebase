import 'package:first_firedase/AppRouter/AppRouter.dart';
import 'package:first_firedase/Views/Home/AddNewCategory.dart';
import 'package:first_firedase/Views/Home/DisplayAllProduacts.dart';
import 'package:first_firedase/Views/Home/UpdateCategory.dart';
import 'package:first_firedase/admin/models/Category.dart';
import 'package:first_firedase/providers/AdminProvider/AdminProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  Category category;

  CategoryWidget(this.category);

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider, _) {
        return InkWell(
          onTap: (){
            Provider.of<AdminProvider>(context , listen: false).getAllProduacts(category.id!);
            AppRouter.navigateToScreen(DisplayAllProduacts(category.id!));
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: Colors.white),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        category.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: MaterialButton(
                        onPressed: () {
                          Provider.of<AdminProvider>(context , listen: false).deleteCategory(category);
                          provider.deleteCategory(category);
                        },
                        child: const Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomStart,
                      child: MaterialButton(
                        onPressed: () {
                          Provider.of<AdminProvider>(context , listen: false).catNameController.text = category.name!;
                          AppRouter.navigateToScreen(UpdateCategory(category));
                        },
                        child: const Icon(
                          Icons.edit,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  category.name!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
