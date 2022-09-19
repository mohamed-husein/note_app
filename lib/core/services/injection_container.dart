import 'package:get_it/get_it.dart';
import 'package:note_app/business/firebase_auth_cubit/firebase_auth_cubit.dart';
import 'package:note_app/data/repository/firebase_repository.dart';
import 'package:note_app/data/web_services/firebase_web_services.dart';
import 'package:shared_preferences/shared_preferences.dart';


GetIt sl =GetIt.instance;

Future<void> init()async
{
  //! Repository
  sl.registerLazySingleton(() => FirebaseRepository(firebaseWebServices: sl()));
  //! Web Services
  sl.registerLazySingleton(() => FirebaseWebServices(sharedPreferences:sl() ));
  //Cubit
  sl.registerFactory(() => FirebaseCubit(firebaseRepository: sl()));
  //! External
  final  sharedPreferences=await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() =>sharedPreferences );
}