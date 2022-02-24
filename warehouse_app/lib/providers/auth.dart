import 'package:flutter/material.dart';
import 'package:warehouse_app/utility.dart';
import 'package:warehouse_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegistered {
  UserRegistered({
    required this.email,
    required this.password,
  });
  String password;
  String email;
}

class AuthProvider with ChangeNotifier {
  String? token;
  String? email;

  List<UserRegistered> users = [
    UserRegistered(email: "ciao@ciao.it", password: "1234")
  ];

  void _setToken(String? newToken) {
    if (token != newToken) {
      token = newToken;
      notifyListeners();
    }
  }

  Future<void> init() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? tempToken = sp.getString(Utility.sharedPreferencesToken);

    if (tempToken != null) {
      _setToken(tempToken);
    }
  }

  Future<void> logout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove(Utility.sharedPreferencesToken);

    _setToken(null);
  }

  Future<void> login(UserLoginDTO user) async {
    for (UserRegistered i in users) {
      if (i.email == user.email && i.password == user.password) {
        email = user.email;
        _setToken("Token");

        final SharedPreferences sp = await SharedPreferences.getInstance();
        await sp.setString(
          Utility.sharedPreferencesToken,
          "Token",
        );
      }
    }

    throw Exception("Invalid credentials");
  }

  Future<void> register(UserRegisterDTO user) async {
    for (UserRegistered i in users) {
      if (i.email == user.email) {
        throw Exception("Email already taken");
      }
    }

    email = user.email;
    _setToken("Token");

    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(
      Utility.sharedPreferencesToken,
      "Token",
    );
  }

  Future<void> remove() async {
    users.removeWhere((element) => element.email == email);
  }
}
