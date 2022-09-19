import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String title;
  final String body;
  final String image;
  final String userId;


  const NoteModel({
    required this.title,
    required this.body,
    required this.image,
    required this.userId,
  });
  @override
  List<Object?> get props => [
        title,
        body,
        image,
        userId,
      ];

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json['title'],
      image: json['image'],
      body: json['body'],
      userId: json['user_id']

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'image': image,
      'user_id':userId,

    };
  }
}
