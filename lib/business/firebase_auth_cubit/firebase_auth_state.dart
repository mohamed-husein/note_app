part of 'firebase_auth_cubit.dart';

abstract class FirebaseState extends Equatable {
  const FirebaseState();

  @override
  List<Object> get props => [];
}

class FirebaseInitial extends FirebaseState {}

class FirebaseSingInAnonErrorState extends FirebaseState {
  final String msg;

  const FirebaseSingInAnonErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class FirebaseSingInAnonSuccessState extends FirebaseState {
  final UserCredential userCredential;

  const FirebaseSingInAnonSuccessState({required this.userCredential});
  @override
  List<Object> get props => [userCredential];
}

class FirebaseSingUpWithEmailAndPassErrorState extends FirebaseState {
  final String msg;

  const FirebaseSingUpWithEmailAndPassErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class FirebaseSingUpWithEmailAndPassSuccessState extends FirebaseState {}

class FirebaseSingInWithEmailAndPassErrorState extends FirebaseState {
  final String msg;

  const FirebaseSingInWithEmailAndPassErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class FirebaseSingInWithEmailAndPassSuccessState extends FirebaseState {
  final UserCredential userCredential;

  const FirebaseSingInWithEmailAndPassSuccessState(
      {required this.userCredential});
  @override
  List<Object> get props => [userCredential];
}

class FirebaseSingOutErrorState extends FirebaseState {
  final String msg;

  const FirebaseSingOutErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class FirebaseSingOutSuccessState extends FirebaseState {
  @override
  List<Object> get props => [];
}

class FirebaseSendVerifyErrorState extends FirebaseState {
  final String msg;

  const FirebaseSendVerifyErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class FirebaseSendVerifySuccessState extends FirebaseState {
  @override
  List<Object> get props => [];
}

class FirebaseSingInWithGoogleErrorState extends FirebaseState {
  final String msg;

  const FirebaseSingInWithGoogleErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class FirebaseSingInWithGoogleSuccessState extends FirebaseState {
  final UserCredential userCredential;

  const FirebaseSingInWithGoogleSuccessState({required this.userCredential});
  @override
  List<Object> get props => [userCredential];
}

class FirebaseChangeVisibilityState extends FirebaseState {}

class FirebaseCreateUserErrorState extends FirebaseState {
  final String msg;

  const FirebaseCreateUserErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class FirebaseCreateUserSuccessState extends FirebaseState {
  @override
  List<Object> get props => [];
}

class FirebaseUpdataUserErrorState extends FirebaseState {
  final String msg;

  const FirebaseUpdataUserErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class FirebaseUpdataUserSuccessState extends FirebaseState {
  @override
  List<Object> get props => [];
}

class FirebaseGetUserDataSuccessState extends FirebaseState {
  final UserModel data;

  const FirebaseGetUserDataSuccessState({required this.data});
  @override
  List<Object> get props => [data];
}

class FirebaseGetUserDataErrorState extends FirebaseState {
  final String msg;
  const FirebaseGetUserDataErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class FirebaseUploadImageErrorState extends FirebaseState {
  const FirebaseUploadImageErrorState();

  @override
  List<Object> get props => [];
}

class FirebaseUploadImageSuccessState extends FirebaseState {}

class FirebaseUploadNoteImageSuccessState extends FirebaseState {}

class FirebaseClearNoteImageSuccessState extends FirebaseState {}

class FirebasPickNoteImageSuccessState extends FirebaseState {
  final File image;

 const FirebasPickNoteImageSuccessState({required this.image});
}

class FirebasPickNoteImageLoadingState extends FirebaseState {}
class FirebaseEditNoteSuccessState extends FirebaseState {}
class FirebaseDeleteNoteSuccessState extends FirebaseState {}


class FirebaseGetNotesSuccessState extends FirebaseState {
  final QueryDocumentSnapshot user;

   const FirebaseGetNotesSuccessState(this.user);

  
  @override
  List<Object> get props => [user];
}

class FirebaseGetNotesErrorState extends FirebaseState {
  final String msg;

  const FirebaseGetNotesErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}
