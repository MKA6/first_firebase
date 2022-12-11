import 'package:first_firedase/AppRouter/AppRouter.dart';
import 'package:first_firedase/Views/Home/AddNewCategory.dart';
import 'package:first_firedase/Views/Home/Category1.dart';
import 'package:first_firedase/admin/models/produacts.dart';
import 'package:first_firedase/helpers/FirestoreHelper.dart';
import 'package:first_firedase/providers/AdminProvider/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayAllCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  AppRouter.navigateToScreen(AddNewCategory());
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              InkWell(
                child: Text('Text' , style: TextStyle(fontSize: 25),),
                onTap: () {
                  FirestoreHelper.firestoreHelper.AddNewProduacts(
                    Produacts(
                        name: "df",
                        description: 'rgeg',
                        catId: '1',
                        id: '5',
                        imageUrl: "",
                        price: '55'),
                  );
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: provider.categories!.length,
            itemBuilder: (context, index) {
              return CategoryWidget(provider.categories![index]);
            },
          ),
        );
      },
    );
  }
}
