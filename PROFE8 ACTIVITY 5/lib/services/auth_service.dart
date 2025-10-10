class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _currentUserEmail;
  String? _currentUserRole;

  // Validate email
  bool validateEmail(String email) {
    return email.contains('@');
  }

  // Validate password
  bool validatePassword(String password) {
    return password.isNotEmpty;
  }

  // Login method
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (validateEmail(email) && validatePassword(password)) {
      _currentUserEmail = email;
      _currentUserRole = 'User'; // Default role
      return true;
    }
    return false;
  }

  // Register method
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (password != confirmPassword) {
      return false;
    }

    if (validateEmail(email) && validatePassword(password)) {
      _currentUserEmail = email;
      _currentUserRole = 'User';
      return true;
    }
    return false;
  }

  // Logout
  void logout() {
    _currentUserEmail = null;
    _currentUserRole = null;
  }

  // Getters
  String? get currentUserEmail => _currentUserEmail;
  String? get currentUserRole => _currentUserRole;
  bool get isLoggedIn => _currentUserEmail != null;
}
