import 'package:chat/colors/colors.dart';
import 'package:chat/social_app/componenet/cash_helper.dart';
import 'package:chat/social_app/componenet/component.dart';
import 'package:chat/social_app/componenet/constant.dart';
import 'package:chat/social_app/cubit_app/cubit.dart';
import 'package:chat/social_app/cubit_app/states.dart';
import 'package:chat/social_app/layout/social_layout.dart';
import 'package:chat/social_app/social_login_screen/login_screen.dart';

import 'package:chat/themes/themes.dart';
import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  print('on background message');
  print(message.data.toString());
  showToast(text: 'on background message', state: ToastStates.SUCCESS,);
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
var token =  await FirebaseMessaging.instance.getToken();
  print('sssss');

print(token);
print('sssss');
FirebaseMessaging.onMessage.listen((event) {
  print('on message');

  print(event.data.toString());
  showToast(text: 'on message', state: ToastStates.SUCCESS);
});
   // Bloc.observer = MyBlocObserver();
  // ShopDioHelper.init();
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message');

    print(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.SUCCESS);

  });


  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  bool isDark = (await CacheHelper.getData(key: 'isDark') ?? false);

  Widget widget;

  // bool onBording = await CacheHelper.getData(key: 'onBoarding')??false ;
   uId = (await CacheHelper.getData(key: 'uId') );
  if(uId != null){
    widget=socialLayout();
  }else
  {
    widget=loginScreen();
  }

  runApp(MYAPP(
    isDark,
    startWidget: widget,
  ));
}

class MYAPP extends StatelessWidget {
  final bool isDark;

  final Widget startWidget;

  MYAPP(
      this.isDark, {
        Key? key,
        required this.startWidget,
      }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    // return MultiBlocProvider(
      // providers:
      // [
      //   BlocProvider(
      //     create: (context) => NewsCubit()
      //       ..getBusiness()
      //       ..getSports()
      //       ..getScience(),
      //   ),
      //   BlocProvider(
      //       create: (BuildContext context) => shopCubit()
      //     // ..changeAppMode(
      //     //   fromShared: isDark,
      //     // ),
      //   ),
      //   BlocProvider(
      //     create: (BuildContext context) => shopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      //   ),
      // ],
      // child: BlocConsumer<shopCubit, shopStates>(
    //       //   listener: (context, state) {},
      //   builder: (context, state) {
    return MultiBlocProvider(
      providers: [

BlocProvider(create: (BuildContext context) => socialCubit()..getUserData()..getPosts())
    ],
        child: BlocConsumer<socialCubit, socialStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: darkTheme,
            darkTheme: lightTheme,
            home: startWidget,
          );


        },
        ),
    );
  }
}

