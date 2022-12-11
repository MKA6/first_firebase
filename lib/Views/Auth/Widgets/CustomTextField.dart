import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String label;

  CustomTextField(this.controller, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: TextFormField(
        controller: controller,
          // الشرط الي بدي ياه
        validator: (String? x){
          if(x == null || x.isEmpty){
            return "error";
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
