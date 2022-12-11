import 'package:first_firedase/Models/AppUser.dart';
import 'package:first_firedase/Views/Auth/Screens/LoginScreen.dart';
import 'package:first_firedase/Views/Auth/Widgets/CustomTextField.dart';
import 'package:first_firedase/helpers/FirestoreHelper.dart';
import 'package:first_firedase/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AuthProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CustomTextField(
                      provider.registerfNameController,
                      'Frisr Name',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CustomTextField(
                      provider.registerlNameController,
                      'Last Name',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CustomTextField(
                      provider.registerPhoneNumberController,
                      'Phone Number',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CustomTextField(
                      provider.registerEmailController,
                      'Email',
                    ),
                  ),  
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CustomTextField(
                      provider.registerPasswordController,
                      'password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provider.register();
                    },
                    child: Text(
                      'Register',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provider.login();
                    },
                    child: Text(
                      'Login',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirestoreHelper.firestoreHelper.getUserFromFirestore('nlGEiWdwPbCuNTHMPWch');
                      FirestoreHelper.firestoreHelper.createNewUser(AppUser('dgfg', 'dffsg', 'dttd', 'fgfg', '4445'));
                    },
                    child: Text(
                      ' Firestore Ttest',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
