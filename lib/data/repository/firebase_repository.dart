
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:note_app/core/error/exception.dart';
import 'package:note_app/core/error/failure.dart';
import 'package:note_app/data/web_services/firebase_web_services.dart';

class FirebaseRepository {
  final FirebaseWebServices firebaseWebServices;

  FirebaseRepository({required this.firebaseWebServices});

  Future<Either<Failure, UserCredential>> signInAnonymous() async {
    try {
      final signInAnon = await firebaseWebServices.signUpAnonymous();
      return Right(signInAnon);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UserCredential>> signUpWithEmailAndPass(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      final signInWithEmailPass =
          await firebaseWebServices.signUpWithEmailAndPass(
              email: email, password: password, name: name, phone: phone);
      return Right(signInWithEmailPass);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UserCredential>> signInWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      final signInWithEmailPass = await firebaseWebServices
          .signInWithEmailAndPass(email: email, password: password);
      return Right(signInWithEmailPass);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Unit>> signOut() async {
    try {
      final signOut = await firebaseWebServices.signOut();
      return Right(signOut);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Unit>> sendEmailVerfiy() async {
    try {
      final sendVerify = await firebaseWebServices.sendEmailVerfiy();
      return Right(sendVerify);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final signWithGoogle = await firebaseWebServices.signInWithGoogle();
      return Right(signWithGoogle);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Unit>> createUser({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final createUserRegister = await firebaseWebServices.createUser(
          email: email, name: name, phone: phone);
      return Right(createUserRegister);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
   Future<Either<Failure, Unit>> updataUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final updataUser = await firebaseWebServices.updateUserData(
          email: email, name: name, phone: phone);
      return Right(updataUser);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

   Future<Either<Failure, Unit>> getUserData() async {
    try {
      final userData = await firebaseWebServices.getUserData();
      return Right(userData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

   Future<Either<Failure, Unit>> uploadImageToDatabase() async {
    try {
      final uploadImage = await firebaseWebServices.uploadImageToDatabase();
      return Right(uploadImage);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
