import 'package:chat/social_app/social_login_screen/social_login_cubit/cubit/cubit_screen.dart';
import 'package:chat/social_app/social_login_screen/social_login_cubit/cubit/states_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../componenet/cash_helper.dart';
import '../componenet/component.dart';
import '../layout/social_layout.dart';
import '../social_register/social_register_Screen.dart';

class loginScreen extends StatelessWidget {
    loginScreen ({Key? key}) : super(key: key);
   final formKey = GlobalKey<FormState>();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   @override
   Widget  build(BuildContext context) {
     return BlocProvider(
       create: (BuildContext ) => socialLoginCubit(),

       child: BlocConsumer<socialLoginCubit,socialLoginStates>(
         listener: (context,state){
           if (state is dateTimeLoginSuccessState)
           {
             navigateAndFinish(context, const socialLayout());
           }
           if(state is dateTimeLoginErrorState) {
             showToast(
               text: state.error!,
               state: ToastStates.Error,
             );
           }

           if(state is dateTimeLoginSuccessState)
             {
               CacheHelper.saveData(
                 key: 'uId',
                 value: state.uId,
               ).then((value) {
                 navigateAndFinish(context,
                     const socialLayout(),
                 );
             });
             } },
         builder:(context,state){
           return Scaffold(
             appBar: AppBar(),
             body: Center(
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Form(
                     key: formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'LOGIN',
                           style: Theme.of(context).textTheme.headline4,
                         ),
                         Text(
                           'login now to communicate with friends',
                           style: Theme.of(context)
                               .textTheme
                               .bodyText1
                               ?.copyWith(color: Colors.grey),
                         ),
                         const SizedBox(
                           height: 30,
                         ),
                         defaultFormField(
                           controller: emailController,
                           type: TextInputType.emailAddress,
                           onSubmit: (value) {},
                           onChange: (value) {},
                           validate: (String value) {
                             if (value.isEmpty) {
                               return 'enter your email address';
                             }
                           },
                           label: 'email address',
                           prefix: Icons.email_outlined,
                         ),
                         const SizedBox(
                           height: 15,
                         ),
                         defaultFormField(
                           controller: passwordController,
                           type: TextInputType.visiblePassword,
                           suffix: socialLoginCubit.get(context).suffix,
                           onChange: (value) {},
                           onSubmit: (value) {
                             if (formKey.currentState!.validate()) {
                               socialLoginCubit.get(context).userLogin(
                                 email: emailController.text,
                                 password: passwordController.text,
                               );
                             }
                           },
                           isPassword: socialLoginCubit.get(context).isPassword,
                           suffixPressed: () {
                             socialLoginCubit.get(context)
                                 .changePasswordVisibility();
                           },
                           validate: (String value) {
                             if (value.isEmpty) {
                               return 'password is short ';
                             }
                           },
                           label: 'password',
                           prefix: Icons.lock,
                         ),
                         const SizedBox(
                           height: 30,
                         ),
                         ConditionalBuilder(
                           condition: state is! dateTimeLogLoadingState,
                           builder: (context) => defaultButton(
                             function: () {
                               if (formKey.currentState!.validate()) {
                                 socialLoginCubit.get(context).userLogin(
                                   email: emailController.text,
                                   password: passwordController.text,
                                 );
                               }
                             },
                             text: 'login',
                             isUpperCase: true,
                           ),

                           fallback: (context) =>
                           const CircularProgressIndicator(),
                         ),
                         const SizedBox(
                           height: 15,
                         ),
                         Row(
                           children: [
                             const Text(
                               'don\'t have an account ',
                             ),
                             TextButton(
                                 onPressed: () {
                                   navigateTo(
                                     context,
                                     socialRegisterScreen(),
                                   );
                                 },
                                 child: const Text(
                                   'REGISTER NOW',
                                   style: TextStyle(
                                     fontSize: 15,
                                     color: Colors.teal,
                                   ),
                                 ))
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ),
             ),
           );
         } ,


       ),
     );
   }
 }
 