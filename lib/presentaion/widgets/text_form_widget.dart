
import 'package:flutter/material.dart';
import 'package:note_app/core/utils/app_colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText ;
  final String hintText;

  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool isSuffix;
  final FormFieldValidator validator;
  final FormFieldSetter onSaved;
   const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
     required this.isSuffix,
     required this.onSaved,
     required this.obscureText,required this.suffixIcon, required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,right: 20,left: 20,bottom: 12),
      child: TextFormField(
        style:  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
        controller: controller,
        obscureText: obscureText,
        onSaved: onSaved,

        validator: (value) =>
          validator(value),
        cursorColor: AppColors.mainColor,
        cursorHeight: 20,
        
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: AppColors.whiteColor,
          filled: true,
          hintText: hintText,
          contentPadding:const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
          
          hintStyle:  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.grey),
          prefixIcon : prefixIcon ,
          suffixIcon : isSuffix==true? suffixIcon : null,
        ),
      ),
    );
  }
}
