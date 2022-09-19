import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/business/firebase_auth_cubit/firebase_auth_cubit.dart';
import 'package:note_app/core/services/injection_container.dart' as di;
import 'package:note_app/core/utils/app_strings.dart';
import 'package:note_app/presentaion/screens/add_note_screen.dart';
import 'package:note_app/presentaion/screens/auth/login_screen.dart';
import 'package:note_app/presentaion/screens/auth/register_screen.dart';
import 'package:note_app/presentaion/screens/main_screen.dart';
import 'package:note_app/presentaion/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouters {
  final saved = di.sl<SharedPreferences>().get(AppStrings.uidKey);
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routers.initialRoute:
        if (saved == null) {
          return MaterialPageRoute(
            builder: (_) {
              return const WelcomeScreen();
            },
          );
        } else {
          return MaterialPageRoute<FirebaseCubit>(builder: (_) {
            return MultiBlocProvider(providers: [
              BlocProvider(create: (context) {
                return di.sl<FirebaseCubit>()..getNotes();
              })
            ], child: const MainScreen());
          });
        }

      case Routers.loginScreen:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<FirebaseCubit>(
                create: (context) {
                  return di.sl<FirebaseCubit>();
                },
                child: LoginScreen());
          },
        );
      case Routers.registerScreen:
        return MaterialPageRoute<FirebaseCubit>(
          builder: (_) {
            return BlocProvider<FirebaseCubit>(
                create: (context) {
                  return di.sl<FirebaseCubit>();
                },
                child: RegisterScreen());
          },
        );
      case Routers.mainScreen:
        return MaterialPageRoute<FirebaseCubit>(
          builder: (_) {
            return BlocProvider(
              create: (context) {
                return di.sl<FirebaseCubit>()..getNotes();
              },
              child: const MainScreen(),
            );
          },
        );
      case Routers.addNoteScreen:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider<FirebaseCubit>(
                create: (context) => di.sl<FirebaseCubit>(),
                child: AddNoteScreen());
          },
        );
      // case Routers.editNoteScreen:
      // return MaterialPageRoute(
      //   builder: (context) {
      //     return BlocProvider(
      //         create: (context) => di.sl<FirebaseCubit>(),
      //         child: EditNoteScreen());
      //   },
      // );

      default:
        return _undefinedRoute();
    }
  }

  Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}

class Routers {
  static const String initialRoute = '/';
  static const String mainScreen = '/mainScreen';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String addNoteScreen = '/addNoteScreen';
  static const String editNoteScreen = '/editNoteScreen';
}
