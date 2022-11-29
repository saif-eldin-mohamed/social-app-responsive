
import 'package:chat/social_app/social_register/cubit/states_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/social_user_model.dart';




class dateTimeRegisterCubit extends Cubit<dateTimeRegisterStates> {
  dateTimeRegisterCubit() : super(socialRegisterInitialState());

  static dateTimeRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,

  })

  {
    emit(socialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password)
        .then((value){
          print(value.user?.email);
          print(value.user?.uid);
userCreate(
    email: value.user?.email,
    password:password,
    name: name,
    phone: phone,
    uId: value.user!.uid);
          // emit(socialRegisterSuccessState());
    })
        .catchError((error){
          print(error.toString());
      emit(socialRegisterErrorState(error.toString()));

    });

  }

  void userCreate({
    required String? email,
    required String ?password,
    required String ?name,
    required String ?phone,
    required String uId,

  })
  {
    socialUserModel model =socialUserModel(
      name: name,
      phone: phone,
      cover: 'https://img.freepik.com/free-photo/adorable-young-boy-playing-with-christmas-toys_23-2148731542.jpg?w=360&t=st=1668268739~exp=1668269339~hmac=6553f45214b58e9fc6b16ad750972b5a3852d773315d8cfea8c7eab3c7aa0361',

      image: 'https://img.freepik.com/free-photo/adorable-young-boy-playing-with-christmas-toys_23-2148731542.jpg?w=360&t=st=1668268739~exp=1668269339~hmac=6553f45214b58e9fc6b16ad750972b5a3852d773315d8cfea8c7eab3c7aa0361',
      bio: 'write your bio ....',
      email: email,
      uId: uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
        model.toMap()).then((value) {
      emit(socialCreateUserSuccessState());
    })
        .catchError((error){
      emit(socialCreateUserErrorState(error.toString()));
    });

  }


     IconData suffix = Icons.visibility_outlined;
     bool isPassword = true;

     void changePasswordVisibility()
     {
       isPassword = !isPassword;
       suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

       emit(socialRegisterChangePasswordVisibilityState());
     }
   }
