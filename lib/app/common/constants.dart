import 'package:flutter/material.dart';

//Colors
const Color kPrimaryColor = Color.fromARGB(255, 190, 52, 85);

//Border Radius
const double kBorderRadius = 16;

//Default Token
const String tokenDefault =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiS2ltIEJpbmgiLCJlbWFpbCI6ImJpbmhAZ21haWwuY29tIiwicGFzc3dvcmQiOiJCaW5oMTIzNCJ9.d1thzqNlWDRYILFTnBA-x8BIldeV31Gk56Os5_U6MP4";

//Constant key
const String kCheckLogin = "CheckLogin";

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
