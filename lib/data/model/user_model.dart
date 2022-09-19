import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String name;
  final String phone;
  final String uId;

  const UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
  });
  @override
  List<Object?> get props => [
        email,
        name,
        phone,
        uId,
      ];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      uId: json['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'email': email,
      'user_id': uId,
      'name': name,
    };
  }
}
