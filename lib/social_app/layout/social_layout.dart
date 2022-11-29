
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../assets/IconBroken.dart';
import '../componenet/component.dart';
import '../cubit_app/cubit.dart';
import '../cubit_app/states.dart';
import '../new_post/newPost_screen.dart';

class socialLayout extends StatelessWidget {
  const socialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit,socialStates>(
      listener:(context,state){
        if (state is socialNewPostState){
          navigateTo(context, newPost());
        }
      } ,
      builder:(context,state){
        var cubit =socialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Feed'),
            actions: [
              IconButton(onPressed: (){}, icon:const Icon( IconBroken.Notification)),
              IconButton(onPressed: (){}, icon:const Icon( IconBroken.Search)),

            ],
          ),
          body:cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
        onTap: (index){
cubit.changeBottomNav(index);
        },
        items: const [
BottomNavigationBarItem(
  icon: Icon(IconBroken.Home),
label: 'home')  ,
          BottomNavigationBarItem(
            icon: Icon(IconBroken.Chat),
              label: 'chats')  ,
          BottomNavigationBarItem(
              icon: Icon(IconBroken.Paper_Upload),
              label: 'new post')  ,

          BottomNavigationBarItem(
            icon: Icon(IconBroken.Location),
              label: 'users')  ,
          BottomNavigationBarItem(
            icon: Icon(IconBroken.Setting),
              label: 'settings')  ,


        ],
        ),


        );
      } ,

    );
  }

}

