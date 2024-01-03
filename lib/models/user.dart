// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:trends_hub/services/data_parser.dart';

class RegisterUser {
  String userId;
  String email;
  String username;
  String createdDate;
  bool isSocial;
  String profileUrl;
  bool isActive;

  RegisterUser({
    required this.userId,
    required this.email,
    required this.username,
    required this.createdDate,
    required this.isSocial,
    required this.profileUrl,
    required this.isActive,
  });

  RegisterUser copyWith({
    String? userId,
    String? email,
    String? username,
    String? createdDate,
    bool? isSocial,
    String? profileUrl,
    bool? isActive,
  }) {
    return RegisterUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      username: username ?? this.username,
      createdDate: createdDate ?? this.createdDate,
      isSocial: isSocial ?? this.isSocial,
      profileUrl: profileUrl ?? this.profileUrl,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'username': username,
      'createdDate': createdDate,
      'isSocial': isSocial,
      'profileUrl': profileUrl,
      'isActive': isActive,
    };
  }

  factory RegisterUser.fromMap(Map<String, dynamic> map) {
    return RegisterUser(
      userId: dataParser.getString(map['userId']),
      email: dataParser.getString(map['email']),
      username: dataParser.getString(map['username']),
      createdDate: dataParser.getString(map['createdDate']),
      isSocial: dataParser.getBool(map['isSocial']),
      profileUrl: dataParser.getString(map['profileUrl']),
      isActive: dataParser.getBool(map['isActive']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterUser.fromJson(String source) =>
      RegisterUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterUser(userId: $userId, email: $email, username: $username, createdDate: $createdDate, isSocial: $isSocial, profileUrl: $profileUrl, isActive: $isActive)';
  }

  @override
  bool operator ==(covariant RegisterUser other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.email == email &&
        other.username == username &&
        other.createdDate == createdDate &&
        other.isSocial == isSocial &&
        other.profileUrl == profileUrl &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        email.hashCode ^
        username.hashCode ^
        createdDate.hashCode ^
        isSocial.hashCode ^
        profileUrl.hashCode ^
        isActive.hashCode;
  }
}
