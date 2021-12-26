import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {Key? key,
      required this.controller,
      required this.label,
      this.textInputType,
      this.hint = ''})
      : super(key: key);
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff1D4350)),
          borderRadius: BorderRadius.circular(6)),
      child: TextFormField(
          keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            contentPadding: const EdgeInsets.only(left: 10),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          )),
    );
  }
}
