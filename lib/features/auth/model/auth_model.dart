/// Auth data model (M in MVC).
class AuthModel {
  const AuthModel({
    this.email = '',
    this.isLoading = false,
  });

  final String email;
  final bool isLoading;

  AuthModel copyWith({String? email, bool? isLoading}) {
    return AuthModel(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
