import 'package:flutter/foundation.dart';
import 'package:redrip/models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isAuthenticated => _currentUser != null;

  Future<bool> login(String email, String password) async {
    // Implement Firebase Auth or your backend
    // For now, mock implementation
    await Future.delayed(Duration(seconds: 1));

    _currentUser = User(
      id: '1',
      name: 'Test User',
      email: email,
      phone: '9876543210',
      address: 'Chennai',
      userType: 'buyer',
      joinedDate: DateTime.now(),
    );

    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();
  }

  Future<bool> register(User user, String password) async {
    // Implement registration
    return true;
  }
}
