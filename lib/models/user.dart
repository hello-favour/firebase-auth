// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String phone;
  final String profileImageUrl;
  final int createdAt;
  final int updatedAt;
  final bool isActive;
  final int dob;
  const User({
    required this.uid,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.dob,
  });

  List<Object> get props {
    return [
      uid,
      email,
      phone,
      profileImageUrl,
      createdAt,
      updatedAt,
      isActive,
      dob,
    ];
  }

  User copyWith({
    String? uid,
    String? email,
    String? phone,
    String? profileImageUrl,
    int? createdAt,
    int? updatedAt,
    bool? isActive,
    int? dob,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isActive': isActive,
      'dob': dob,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      profileImageUrl: map['profileImageUrl'] as String,
      createdAt: map['createdAt'] ?? 0,
      updatedAt: map['updatedAt'] ?? 0,
      isActive: map['isActive'] ?? false,
      dob: map['dob'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
