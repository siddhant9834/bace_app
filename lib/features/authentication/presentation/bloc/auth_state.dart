
import 'package:mayapur_bace/core/side_drawer/data/model/user_profile_model.dart';

abstract class AuthState{
  const AuthState();

  
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class UserAuthenticated extends AuthState {
 final  String message;

  UserAuthenticated({required this.message});

}
class UserRegisteredState extends AuthState{
  final String message;

  UserRegisteredState({required this.message});
}

class AuthErrorState extends AuthState {
  final String message;

   AuthErrorState({required this.message});


}


class ProfileFetchSuccessState extends AuthState{
  ProfileModel userData;
  ProfileFetchSuccessState({required this.userData});
}

// class ShowBottomModalSheetState extends AuthState{
//     final String newBio;

//   ShowBottomModalSheetState({required this.newBio});
// }

// class ShowImagePickerOptionState extends AuthState {}


// class ProfileImageChangedState extends AuthState {
//   final String imageUrl;

//   ProfileImageChangedState({required this.imageUrl});
// }

// class RegisterUserState extends AuthState{

// }