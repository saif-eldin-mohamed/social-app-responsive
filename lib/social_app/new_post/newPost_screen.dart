import 'package:chat/assets/IconBroken.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../componenet/component.dart';
import '../cubit_app/cubit.dart';
import '../cubit_app/states.dart';

class newPost extends StatelessWidget {
  var textController= TextEditingController();
  var dateTimeController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit, socialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'create post',
              actions: [defaultTextButton(function: () {
                var now =DateTime.now();
                if(socialCubit.get(context).postImage == null){
                  socialCubit.get(context).createPost(
                      dateTime: now.toLocal().toString(),
                      text: textController.text
                  );
                }else{
                  socialCubit.get(context).uploadPostImage(
                      dateTime: now.toLocal().toString(),
                      text: textController.text);
                }
              }, text: 'post')]),
          body: Padding(

            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is socialCreatePostLoadingState )
                LinearProgressIndicator(),
        if(state is socialCreatePostLoadingState)

        SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/happy-student-posing-against-pink-wall_273609-20447.jpg?w=1060&t=st=1668028440~exp=1668029040~hmac=1f70839c0b24e786fb01d609aa3b51ceac59cd78539759e2d5c2ce7dcd188263',
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'saif mohamed',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height:20 ,),
                if(socialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: FileImage(socialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                      onPressed: () {
                        socialCubit.get(context).removePostImage();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20,),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            socialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5,),
                              Text('add photo'),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Text('# tags')),
                    ),

                  ],
            ),
          ])
            ),

        );
      },
    );
  }
}
