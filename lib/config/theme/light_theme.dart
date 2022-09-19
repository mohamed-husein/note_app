import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/core/utils/app_colors.dart';
import 'package:note_app/core/utils/app_strings.dart';

ThemeData lightTheme(context) => ThemeData(
      primaryColor: AppColors.mainColor,
      fontFamily: AppStrings.fontFamily,
      appBarTheme: AppBarTheme(
        color: AppColors.greyColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25,fontWeight: FontWeight.w700),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.mainColor,
        foregroundColor: AppColors.whiteColor
      ),
      scaffoldBackgroundColor: AppColors.greyColor,
      textTheme:  TextTheme(
        headline1:const TextStyle(
          color:AppColors.blackColor,
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
        headline2:const TextStyle(
          color:AppColors.blackColor,
          fontWeight: FontWeight.w700,
          fontSize: 23,
        ),
        bodyText1: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
          fontSize: 23,
        ),
         bodyText2: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
          fontSize: 19,
        ),
        button:const TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w500,
          fontSize: 23,
        ),
      ),
    );
