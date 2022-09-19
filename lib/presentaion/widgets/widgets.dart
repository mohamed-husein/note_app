import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/business/firebase_auth_cubit/firebase_auth_cubit.dart';
import 'package:note_app/config/app_routes/app_routes.dart';


Widget signOut(context){
  return Center(
            child: BlocListener<FirebaseCubit, FirebaseState>(
              listener: (context, state) {
                if (state is FirebaseSingOutSuccessState) {
                  Navigator.pushReplacementNamed(context, Routers.loginScreen);
                }
              },
              child: MaterialButton(
                onPressed: () {
                  BlocProvider.of<FirebaseCubit>(context).signOut();
                },
                color: Theme.of(context).primaryColor,
                child: const Text('Sign Out'),
              ),
            ),
          );
}