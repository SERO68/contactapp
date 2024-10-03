
import 'package:flutter/material.dart';

class Formfield extends StatelessWidget {
  const Formfield({
    super.key,
    required this.namecontroller,
    required this.hinttext,
    required this.validator,
  });

  final TextEditingController namecontroller;
  final String hinttext;
  final String? Function(dynamic) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: namecontroller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: hinttext),
      validator: validator,
    );
  }
}
