import 'package:flutter/material.dart';
import 'package:nkap/colors/colors.dart';

import '../../styles/text_styles.dart';


class CustomFormField extends StatelessWidget {
  final String headingText;
  final String hintText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  TextInputAction? textInputAction;
  final TextEditingController controller;
  AutovalidateMode autoValidateMode;
  final int maxLines;
  bool obscureText;
  String? Function(dynamic value) validator;

  CustomFormField(
      {Key? key,
      required this.headingText,
      required this.hintText,
      required this.suffixIcon,
      required this.textInputType,
      this.textInputAction,
      required this.controller,
      required this.maxLines,
        required this.obscureText,
        required this.autoValidateMode,
         required this.validator,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headingText,
            style: KTextStyle.textFieldHeading,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: NkapColors.secondary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              obscureText: obscureText,
              maxLines: maxLines,
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              autovalidateMode:  autoValidateMode,
              validator: validator,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: KTextStyle.textFieldHintStyle,
                  border: InputBorder.none,
                  suffixIcon: suffixIcon),
            ),
          ),
        )
      ],
    );
  }
}
