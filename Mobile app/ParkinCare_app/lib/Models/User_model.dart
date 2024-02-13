import 'package:flutter/foundation.dart';

class UserModel {
  String? uid;
  String? email;
  String? Name;
  String? password;

  UserModel({this.uid, this.Name, this.password, this.email});
//fetch data from server

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        Name: map['Name'],
        password: map['password']);
  }
  //sending data to user
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'Name': Name, 'password': password};
  }
}
