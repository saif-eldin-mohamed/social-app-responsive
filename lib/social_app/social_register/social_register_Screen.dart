import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../componenet/component.dart';
import '../layout/social_layout.dart';
import 'cubit/cubit_screen.dart';
import 'cubit/states_screen.dart';

final formKey = GlobalKey<FormState>();
final emailController = TextEditingController();
final passwordController = TextEditingController();
var phoneController = TextEditingController();
var nameController = TextEditingController();

class socialRegisterScreen extends StatelessWidget {
   socialRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext? context) =>dateTimeRegisterCubit() ,


      child: BlocConsumer<dateTimeRegisterCubit,dateTimeRegisterStates>(
        listener: (context,state){
          if (state is socialCreateUserSuccessState)
          {
            navigateAndFinish(context, const socialLayout());
          }

      },
        builder: (context,state){
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'register now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          onSubmit: (value) {},
                          onChange: (value) {},
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'enter your name ';
                            }
                          },
                          label: ' user name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          onSubmit: (value) {},
                          onChange: (value) {},
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'enter your email address ';
                            }
                          },
                          label: ' email address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: dateTimeRegisterCubit.get(context).suffix,
                          onChange: (value) {},
                          onSubmit: (value) {
                            // if (formKey.currentState!.validate()) {
                            //   socialLoginCubit.get(context).userLogin(
                            //     email: emailController.text,
                            //     password: passwordController.text,
                            //   );
                            // }
                          },
                          isPassword: dateTimeRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            dateTimeRegisterCubit.get(context)
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
                          height: 15,
                        ),

                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          onSubmit: (value) {},
                          onChange: (value) {},
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'enter your email phone number ';
                            }
                          },
                          label: '  phone number',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! socialRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                dateTimeRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,

                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                          const CircularProgressIndicator(),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
