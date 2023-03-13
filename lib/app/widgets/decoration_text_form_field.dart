import 'package:flutter/material.dart';

import '../../data/constants.dart';

//Decoration of TextFormField
InputDecoration decorationTextFormField(
    {required String hintText, IconData? icon}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
        vertical: kBorderRadius, horizontal: kBorderRadius),
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.grey[500]),
    focusColor: kPrimaryColor,
    prefixIcon: icon != null
        ? Icon(
            icon,
            color: kPrimaryColor,
          )
        : null,
    filled: true,
    fillColor: Colors.grey[200],
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: const BorderSide(color: Colors.red),
    ),
  );
}
