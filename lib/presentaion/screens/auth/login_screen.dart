import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/business/firebase_auth_cubit/firebase_auth_cubit.dart';
import 'package:note_app/config/app_routes/app_routes.dart';
import 'package:note_app/core/utils/app_colors.dart';
import 'package:note_app/core/utils/app_strings.dart';
import 'package:note_app/core/utils/media_query.dart';
import 'package:note_app/presentaion/widgets/text_form_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greyColor,
        elevation: 0,
      ),
      body: SizedBox(
        width: context.width,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  AppStrings.loginTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: AppColors.mainColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    AppStrings.loginBody,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 27),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormFieldWidget(
                  controller: emailController,
                  hintText: 'email',
                  onSaved: (newValue) {
                    
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset("assets/icons/envelope.svg",
                        color: AppColors.mainColor),
                  ),
                  validator: (value) {
                    if (!RegExp(AppStrings.validationEmail).hasMatch(value)) {
                      return 'Enter valid name';
                    }
                    return null;
                  },
                  isSuffix: false,
                  obscureText: false,
                  suffixIcon: Container(),
                ),
                BlocBuilder<FirebaseCubit, FirebaseState>(
                  builder: (context, state) => TextFormFieldWidget(
                    onSaved: (newValue) {
                      
                    },
                    controller: passController,
                    hintText: 'Password',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset("assets/icons/lock.svg",
                          color: AppColors.mainColor),
                    ),
                    validator: (value) {
                      if (value.toString().length < 6) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                    isSuffix: true,
                    obscureText:
                        BlocProvider.of<FirebaseCubit>(context).isVisible
                            ? false
                            : true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        BlocProvider.of<FirebaseCubit>(context)
                            .changeIconVisibility();
                      },
                      icon: BlocProvider.of<FirebaseCubit>(context).isVisible
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: AppColors.mainColor,
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: AppColors.mainColor,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, right: 20, left: 20, bottom: 12),
                  child: BlocListener<FirebaseCubit, FirebaseState>(
                    listener: (context, state) {
                      if (state is FirebaseSingInWithEmailAndPassSuccessState) {
                        Navigator.pushReplacementNamed(
                            context, Routers.mainScreen);
                      }
                    },
                    child: MaterialButton(
                      color: AppColors.mainColor,
                      height: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<FirebaseCubit>(context)
                              .signInWithEmailAndPass(
                                  email: emailController.text,
                                  password: passController.text);
                        }
                      },
                      child: SizedBox(
                        width: context.width,
                        child: Center(
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(AppStrings.continueLoginOrRegister),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          BlocProvider.of<FirebaseCubit>(context).signInWithGoogle();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          width: 80,
                          height: 60,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/search.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        width: 80,
                        height: 60,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/images/facebook.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        width: 80,
                        height: 60,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/images/apple.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have Account",style: TextStyle(fontSize: 15)),
            TextButton(
              
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routers.registerScreen);
                },
                
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding: const EdgeInsets.only(bottom: 5,left: 5),
                ),
                child: const Text('Register Now', style: TextStyle(color: Colors.blue)))
          ],
        ),
      ),
    );
  }
}
