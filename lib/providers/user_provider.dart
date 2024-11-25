import 'package:flutter/material.dart';

import '../pages/login/model/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userProfile;

  UserModel? get userProfile => _userProfile;

  void setUserProfile(UserModel user) {
    _userProfile = user;
    notifyListeners();
  }

  void clearUserProfile() {
    _userProfile = null;
    notifyListeners();
  }
}
