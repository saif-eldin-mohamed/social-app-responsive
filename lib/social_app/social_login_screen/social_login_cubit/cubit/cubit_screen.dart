import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chat/social_app/social_login_screen/social_login_cubit/cubit/states_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class socialLoginCubit extends Cubit<socialLoginStates> {
  socialLoginCubit() : super(dateTimeLoginInitialState());

  static socialLoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,

  })
  {
    emit(dateTimeLogLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value){
      print(value.user?.email);
      print(value.user?.uid);
      emit(dateTimeLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(dateTimeLoginErrorState(error));
    });
  }
  // dateTimeLoginModel? loginModel;

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(dateTimeLogLoadingState());
  //
  //   dateTimeDioHelper.postData(
  //     url: LOGIN,
  //     data: {
  //       'email': email,
  //       'password': password,
  //     },
  //   ).then((value) {
  //     print(value?.data);
  //     loginModel = dateTimeLoginModel.fromJson(value?.data);
  //     emit(dateTimeLoginSuccessState(loginModel!));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(dateTimeLoginErrorState(error.toString()));
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(dateTimeChangePasswordVisibilityState());
  }


}
