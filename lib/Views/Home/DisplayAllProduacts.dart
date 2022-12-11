import 'package:first_firedase/AppRouter/AppRouter.dart';
import 'package:first_firedase/Views/Home/AddNewProduact.dart';
import 'package:first_firedase/providers/AdminProvider/AdminProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayAllProduacts extends StatelessWidget {
  String catId;

  DisplayAllProduacts(this.catId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.navigateToScreen(AddNewProduact(catId));
              },
              icon: Icon(Icons.add)),
        ],
      ),
      /**
       * Center(child: Container(
          child: Text(provider.produact?.length.toString()??"empty"),
          ));*/
      body: Consumer<AdminProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
              itemCount: provider.produact?.length ?? 0,
              itemBuilder: (context, indext) {
                return Column(
                  children: [
                    Image.network(provider.produact?[indext].imageUrl ?? '' , height: 200 , width: double.infinity,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(provider.produact?[indext].description??''),
                        SizedBox(width: 20,),
                        Text(provider.produact?[indext].price??''),
                        SizedBox(width: 20,),
                        Text(provider.produact?[indext].name??''),
                      ],
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
