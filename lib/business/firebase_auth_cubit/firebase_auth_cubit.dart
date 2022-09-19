import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/core/error/failure.dart';
import 'package:note_app/core/services/injection_container.dart';
import 'package:note_app/core/utils/app_strings.dart';
import 'package:note_app/data/model/note_model.dart';
import 'package:note_app/data/model/user_model.dart';
import 'package:note_app/data/repository/firebase_repository.dart';
import 'package:note_app/data/web_services/firebase_web_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'firebase_auth_state.dart';

class FirebaseCubit extends Cubit<FirebaseState> {
  FirebaseCubit({required this.firebaseRepository}) : super(FirebaseInitial());

  final FirebaseRepository firebaseRepository;

  Future<void> signInAnonymous() async {
    final result = await firebaseRepository.signInAnonymous();
    result.fold(
        (l) => emit(FirebaseSingInAnonErrorState(msg: _handleErrorMessage(l))),
        (r) => emit(FirebaseSingInAnonSuccessState(userCredential: r)));
  }

  Future<void> signUpWithEmailAndPass(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    final result = await firebaseRepository.signUpWithEmailAndPass(
        email: email, password: password, name: name, phone: phone);

    result.fold(
        (l) => emit(FirebaseSingUpWithEmailAndPassErrorState(
            msg: _handleErrorMessage(l))), (r) {
      createUser(name: name, email: email, phone: phone);
      emit(FirebaseSingUpWithEmailAndPassSuccessState());
    });
  }

  Future<void> signInWithEmailAndPass(
      {required String email, required String password}) async {
    final result = await firebaseRepository.signInWithEmailAndPass(
        email: email, password: password);
    result.fold(
        (l) => emit(FirebaseSingInWithEmailAndPassErrorState(
            msg: _handleErrorMessage(l))),
        (r) => emit(
            FirebaseSingInWithEmailAndPassSuccessState(userCredential: r)));
  }

  Future<void> signOut() async {
    final result = await firebaseRepository.signOut();
    result.fold(
        (l) => emit(FirebaseSingOutErrorState(msg: _handleErrorMessage(l))),
        (r) {
      sl<SharedPreferences>().remove(AppStrings.uidKey);
      emit(FirebaseSingOutSuccessState());
    });
  }

  Future<void> sendEmailVerfiy() async {
    final result = await firebaseRepository.sendEmailVerfiy();
    result.fold(
        (l) => emit(FirebaseSendVerifyErrorState(msg: _handleErrorMessage(l))),
        (r) => emit(FirebaseSendVerifySuccessState()));
  }

  Future<void> signInWithGoogle() async {
    final result = await firebaseRepository.signInWithGoogle();
    result.fold(
        (l) => emit(
            FirebaseSingInWithGoogleErrorState(msg: _handleErrorMessage(l))),
        (r) => emit(FirebaseSingInWithGoogleSuccessState(userCredential: r)));
  }

  Future<void> createUser({
    required String name,
    required String email,
    required String phone,
  }) async {
    final result = await firebaseRepository.createUser(
        email: email, name: name, phone: phone);
    result.fold(
        (l) => emit(FirebaseCreateUserErrorState(msg: _handleErrorMessage(l))),
        (r) => emit(FirebaseCreateUserSuccessState()));
  }

  Future<void> updataUser({
    required String name,
    required String email,
    required String phone,
  }) async {
    final result = await firebaseRepository.updataUserData(
        email: email, name: name, phone: phone);
    result.fold(
        (l) => emit(FirebaseUpdataUserErrorState(msg: _handleErrorMessage(l))),
        (r) => emit(FirebaseUpdataUserSuccessState()));
  }

  Future<void> getUserData() async {
    emit(FirebaseInitial());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      emit(FirebaseGetUserDataSuccessState(
          data: UserModel.fromJson(value.data()!)));
    }).catchError((error) {
      emit(FirebaseGetUserDataErrorState(msg: e.toString()));
    });
  }

  ImagePicker image = ImagePicker();

  late File noteImage;

  void clearImage() {
    noteImage = File('');
    emit(FirebaseClearNoteImageSuccessState());
  }

  Future uploadNoteImage() async {
    final pickImage = await image.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      noteImage = File(pickImage.path);
      emit(FirebasPickNoteImageSuccessState(image: File(pickImage.path)));
    } else {
      debugPrint('No Image to upload');
    }
  }

  late NoteModel noteModel;
  Future addNotes({
    required String title,
    required String body,
  }) async {
    await FirebaseStorage.instance
        .ref()
        .child('notes/${Uri.file(noteImage.path).pathSegments.last}')
        .putFile(noteImage)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('notes')
            .doc()
            .set({
          'title': title,
          'body': body,
          'image': value,
          'user_id': auth.currentUser!.uid
        });
      });

      emit(FirebaseUploadNoteImageSuccessState());
      getNotes();
      notes = [];
      notesId = [];
    });
  }

  List<NoteModel> notes = [];
  List notesId = [];

  Future<void> getNotes() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('notes')
        .get()
        .then((value) {
      for (var element in value.docs) {
        notes.add(NoteModel.fromJson(element.data()));
        notesId.add(element.id);
        emit(FirebaseGetNotesSuccessState(element));
      }
    }).catchError((error) {
      emit(FirebaseGetNotesErrorState('error : -------- ${error.toString()}'));
    });
  }

  Future<void> updataNotes(
      {required String title, required String body, required docId}) async {
    await FirebaseStorage.instance
        .ref()
        .child(
            'notes/${Random().nextInt(1000000)}${Uri.file(noteImage.path).pathSegments.last}')
        .putFile(noteImage)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) async {
        final NoteModel noteModel = NoteModel(
            title: title,
            body: body,
            image: value,
            userId: auth.currentUser!.uid);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('notes')
            .doc(docId)
            .update(noteModel.toMap());
      });

      emit(FirebaseEditNoteSuccessState());
      notes = [];
      notesId = [];
      getNotes();
    });
  }

  Future<void> deleteNotes({required docId}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('notes')
        .doc(docId)
        .delete();

    emit(FirebaseDeleteNoteSuccessState());
    notes = [];
    notesId = [];
    getNotes();
  }

  String _handleErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      default:
        return AppStrings.unExpectedFailure;
    }
  }

  bool isVisible = false;
  void changeIconVisibility() {
    emit(FirebaseInitial());
    isVisible = !isVisible;
    emit(FirebaseChangeVisibilityState());
  }

  void getToken() {
    FirebaseMessaging.onMessage.listen((event) {
      print('====================================');
      print('${event.notification!.title}');
      print('====================================');
    });
  }
}
