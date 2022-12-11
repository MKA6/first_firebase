import 'package:first_firedase/AppRouter/AppRouter.dart';
import 'package:first_firedase/Views/Auth/Screens/RegisterScreen.dart';
import 'package:first_firedase/Views/Auth/Widgets/CustomTextField.dart';
import 'package:first_firedase/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Consumer<AuthProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CustomTextField(
                      provider.loginEmailController,
                      'Email',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CustomTextField(
                      provider.loginPasswordController,
                      'password',
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
                      AppRouter.navigateAndReplaceScreen(RegisterScreen());
                      },
                    child: Text(
                      'Created new Account',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
