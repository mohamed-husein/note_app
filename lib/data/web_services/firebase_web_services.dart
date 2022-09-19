import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/core/utils/app_strings.dart';
import 'package:note_app/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FirebaseWebServices {
  final SharedPreferences sharedPreferences;

  FirebaseWebServices({required this.sharedPreferences});

  Future<UserCredential> signUpAnonymous() async {
    UserCredential singInAnon = await auth.signInAnonymously();
    return singInAnon;
  }

  Future<UserCredential> signUpWithEmailAndPass(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    UserCredential singWithEmailPass = await auth
        .createUserWithEmailAndPassword(email: email, password: password);
    sharedPreferences.setString(AppStrings.uidKey, singWithEmailPass.user!.uid);
    return singWithEmailPass;
  }

  Future<UserCredential> signInWithEmailAndPass(
      {required String email, required String password}) async {
    UserCredential singWithEmailPass =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    sharedPreferences.setString(AppStrings.uidKey, singWithEmailPass.user!.uid);
    return singWithEmailPass;
  }

  Future<Unit> signOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    return Future.value(unit);
  }

  Future<Unit> sendEmailVerfiy() async {
    await auth.currentUser!.sendEmailVerification();
    return Future.value(unit);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  Future<Unit> createUser({
    required String name,
    required String email,
    required String phone,
  }) async {
    UserModel user = UserModel(
        email: email, name: name, phone: phone, uId: auth.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toMap());
    return Future.value(unit);
  }

  Future<Unit> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    UserModel userModel = UserModel(
        email: email, name: name, phone: phone, uId: auth.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(userModel.toMap());
    return Future.value(unit);
  }

  Future<Unit> getUserData() async {
    DocumentReference userDataInfo = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid);
    await userDataInfo.get();
    return Future.value(unit);
  }

  late File uploadFile;
  ImagePicker image = ImagePicker();

  Future pickImageToUpload() async {
    final imageToUpload = await image.pickImage(source: ImageSource.gallery);
    if (imageToUpload != null) {
      uploadFile = File(imageToUpload.path);
      //print(Uri.file(uploadFile.path).pathSegments.last);
    } else {
      debugPrint('No Image to upload');
    }
  }

  Future<Unit> uploadImageToDatabase() async {
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(uploadFile.path).pathSegments.last}')
        .putFile(uploadFile)
        .then((p0) => p0.ref.getDownloadURL());
        return Future.value(unit);
  }
}
