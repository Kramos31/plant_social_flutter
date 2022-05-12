import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:plant_social_flutter/models/user.dart';
import 'package:plant_social_flutter/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
