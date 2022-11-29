import 'package:chat/assets/IconBroken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../colors/colors.dart';
import '../cubit_app/cubit.dart';
import '../cubit_app/states.dart';
import '../model/messages_model.dart';
import '../model/social_user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  socialUserModel? userModel;

  ChatDetailsScreen({
    this.userModel,
  });
var messagesController =TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Builder(
      builder: (context) {
        socialCubit.get(context).getMessages(receiverId: userModel!.uId!);
        return BlocConsumer<socialCubit, socialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel!.image!,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel!.name!,
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition:socialCubit.get(context).messages.length >0 ,
                builder:(context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                 Expanded(
                   child: ListView.separated(
                     physics: BouncingScrollPhysics(),
                       itemBuilder: (context,index)
                     {
                       var message = socialCubit.get(context).messages[index];
                       if(socialCubit.get(context).userModel!.uId! == message) {
                            return buildMessages(message);

                          } return buildMyMessages(message);
                        },
                       separatorBuilder: (context,index)  => SizedBox(
                         height: 15,
                       ),
                       itemCount:  socialCubit.get(context).messages.length ,),
                 ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black12,
                              width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messagesController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message ...',
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: ()
                                {
                                  socialCubit.get(context).sendMessage(
                                      receiverId: userModel!.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messagesController.text
                                  );
                                },
                                minWidth: 1,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ) ,
                fallback:(context) => Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      }
    );
  }

  Widget buildMessages (socialMessagesModel model) =>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        padding: EdgeInsets.symmetric(
            vertical: 5, horizontal: 10),
        child: Text(model.text!)),
  );

  Widget buildMyMessages (socialMessagesModel model) =>  Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        decoration: BoxDecoration(
            color: defaultColor.withOpacity(.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        padding: EdgeInsets.symmetric(
            vertical: 5, horizontal: 10),
        child: Text(model.text!)),
  );
}
