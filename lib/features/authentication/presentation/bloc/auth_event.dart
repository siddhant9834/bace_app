abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);
}

class FetchProfileDataEvent extends AuthEvent {
  final String phoneNumber;

  FetchProfileDataEvent({required this.phoneNumber});
}

class ShowBottomModalSheetEvent extends AuthEvent {
  final String newBio;

  ShowBottomModalSheetEvent({required this.newBio});
}

class ShowImagePickerOptionEvent extends AuthEvent {}

class ChangeProfileImageEvent extends AuthEvent {
  final String imageUrl;

  ChangeProfileImageEvent(this.imageUrl);
}

class RegisterUserEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  const RegisterUserEvent({required this.fullName, required this.email, required this.phoneNumber, required this.password});
}
