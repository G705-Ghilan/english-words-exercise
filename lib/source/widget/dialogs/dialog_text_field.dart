import 'package:english_words_exercise/source/constance.dart';
import 'package:flutter/material.dart';

class DialogTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? errorText;
  final int? maxLength;
  final void Function(String)? onChanged;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  const DialogTextField(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.errorText,
      required this.textEditingController,
      this.maxLength,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      autofocus: true,
      controller: textEditingController,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: CONSTANCE.defaultBorderRadius,
          borderSide:
              BorderSide(width: 1, color: Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }
}
