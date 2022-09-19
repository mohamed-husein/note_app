import 'package:flutter/material.dart';
import 'package:note_app/config/app_routes/app_routes.dart';

import 'package:note_app/core/utils/app_colors.dart';
import 'package:note_app/core/utils/app_strings.dart';
import 'package:note_app/core/utils/media_query.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: Column(
        children: [
          const SizedBox(
            height: 45,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: context.width,
            height: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.mainColor),
            child: Image.asset('assets/images/background.png'),
          ),
          const SizedBox(
            height: 70,
          ),
          Text(
            AppStrings.welcomeTitle,
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppStrings.welcomeBody,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10)
            ),
              width: context.width - 90,
              height: 70,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10)
              ),
                width: context.width - 100,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:  BorderRadius.circular(10)
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routers.registerScreen);
                        },
                        minWidth: (context.width - 100) / 2,
                        height: 70,
                        child:  Text(AppStrings.register,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).scaffoldBackgroundColor),),
                      ),
                    ),
                    Container(
                      decoration:const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius:  BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routers.loginScreen);
                        },
                        height: 70,
                        minWidth: (context.width - 100) / 2,
                        child: const Text(AppStrings.signIn,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
