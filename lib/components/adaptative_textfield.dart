import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  //label, onsubmit, controller, keyboard type.

  final String label;
  final VoidCallback onSubmitted;
  final TextEditingController controller;
  final TextInputType? inputType;

  const AdaptativeTextField({
    Key? key,
    required this.label,
    required this.onSubmitted,
    required this.controller,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controller,
              onSubmitted: (_) => onSubmitted,
              keyboardType: inputType,
              placeholder: label,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller: controller,
            onSubmitted: (_) => onSubmitted,
            decoration: InputDecoration(
              labelText: label,
              floatingLabelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            cursorColor: Theme.of(context).colorScheme.primary,
            keyboardType: inputType,
          );
  }
}
