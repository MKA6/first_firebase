import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProfileItem extends StatelessWidget {
  String label;
  String content;
  TextEditingController controller;

  CustomProfileItem(this.label, this.content, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (String? x){
                if(x == null || x.isEmpty){
                  return "error";
                }
              },
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
