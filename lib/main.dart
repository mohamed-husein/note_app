import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc_observer.dart';
import 'package:note_app/config/app_routes/app_routes.dart';
import 'package:note_app/config/theme/light_theme.dart';
import 'package:note_app/core/services/injection_container.dart' as di;

Future backgroundMessage(RemoteMessage message)async{
  print('=====================Message==================');
     print('${message.notification!.title}');
      print('====================================');
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await di.init();
  FirebaseMessaging.onBackgroundMessage(backgroundMessage);
  runApp(MyApp(appRouters: AppRouters(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouters,}) : super(key: key);
  final AppRouters appRouters;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme(context),
      onGenerateRoute:  appRouters.onGenerateRoute,
    );
  }
}



