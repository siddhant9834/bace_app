import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/side_drawer/data/datasource/FB_auth_services.dart';
import 'package:mayapur_bace/features/authentication/data/FireB_auth_impl_datasource.dart/firebase_auth_services_impl.dart';
import 'package:mayapur_bace/core/side_drawer/data/model/user_profile_model.dart';
import 'package:mayapur_bace/features/authentication/domain/usecases/auth_usecases.dart';
import 'package:mayapur_bace/core/side_drawer/domain/usecases/get_profile_usecases.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_event.dart';
import 'package:mayapur_bace/features/authentication/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    // on<ChangeProfileImageEvent>(changeProfileImageEvent);
    on<RegisterUserEvent>(registerUserEvent);
    // on<ShowImagePickerOptionEvent>(showImagePickerOptionEvent);
    on<LoginEvent>(loginEvent);
    // on<FetchProfileDataEvent>(fetchProfileData);
  }

  Future<void> registerUserEvent(event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final message = await locator<AuthUseCases>().registerUser(
      email: event.email,
      password: event.password,
      fullName: event.fullName,
      phoneNumber: event.phoneNumber,
    );

    if (message != null && message.contains('Success')) {
      emit(UserRegisteredState(message: message));
    } else {
      log('Register Event: ${message}');

      emit(AuthErrorState(message: message ?? 'Registration failed'));
    }
  }

  Future<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    final message =
        await locator<AuthUseCases>().loginUser(event.email, event.password);

    if (message != null && message.contains('Success')) {
      emit(UserAuthenticated(message: message));
      // User? user = FirebaseAuth.instance.currentUser;
      // if (user != null) {
      //   log(user.phoneNumber.toString());
      //   // add(FetchProfileDataEvent(phoneNumber: user.phoneNumber ?? ''));
      //           add(FetchProfileDataEvent(phoneNumber: '9834599998' ?? ''));

      // }
    } else {
      emit(AuthErrorState(message: message ?? 'Login failed'));
    }
  }

  // FutureOr<void> changeProfileImageEvent(
  //     ChangeProfileImageEvent event, Emitter<AuthState> emit) {
  //   emit(ProfileImageChangedState(imageUrl: event.imageUrl));
  // }

  // FutureOr<void> showImagePickerOptionEvent(
  //     ShowImagePickerOptionEvent event, Emitter<AuthState> emit) {
  //   emit(ShowImagePickerOptionState());
  // }

  // FutureOr<void> fetchProfileData(
  //     FetchProfileDataEvent event, Emitter<AuthState> emit) {
  //   // Stream<ProfileModel> userData=locator<GetProfileUseCase>().call(ProfileService().getPhoneNumber().toString());
  //   try {
  //     log('in fetch profile data event');
  //     emit(AuthLoading());
  //     // Ensure the phone number is not null or empty
  //     // if (event.phoneNumber.isNotEmpty) {
  //     //       Stream<ProfileModel> userData = ProfileService().('9834599998');
  //       // Stream<ProfileModel> userData =
  //       //     locator<GetProfileUseCase>().call(event.phoneNumber);
  //       // emit(ProfileFetchSuccessState(userData: userData));
  //     } else {
  //       emit(AuthErrorState(message: 'Phone number is empty'));
  //     }
  //   } catch (e) {
  //     emit(AuthErrorState(message: 'Error fetching profile data: $e'));
  //   }
  //   // log(userData.toString());
  //   // emit(ProfileFetchSuccessState(userData: userData));
  // }
}
