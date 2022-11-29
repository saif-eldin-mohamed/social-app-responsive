
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../assets/IconBroken.dart';
import '../componenet/component.dart';
import '../cubit_app/cubit.dart';
import '../cubit_app/states.dart';
import '../edit_profile/edite_profile.dart';

class settingsScreen extends StatelessWidget {
  const settingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit, socialStates>(
  listener: (context, state) {},
  builder: (context, state) {

    var userModel =socialCubit.get(context).userModel;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            height: 190,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(

                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        image: DecorationImage(
                          image: NetworkImage('${userModel!.cover}'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  alignment: Alignment.topCenter,

                ),
                CircleAvatar(
                  radius: 64.0,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundImage:
                    NetworkImage(
                        '${userModel.image}'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0,),
          Text('${userModel.name}',
          style: Theme.of(context).textTheme.subtitle1,),
          Text('${userModel.bio}',
            style: Theme.of(context).textTheme.caption,),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0
            ),
            child: Row(
              children: [
                Expanded(

                  child: InkWell(
                    child: Column(
                      children: [
                        Text('100',
                          style: Theme.of(context).textTheme.subtitle2,),
                        Text('posts',
                          style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(

                  child: InkWell(
                    child: Column(
                      children: [
                        Text('190',
                          style: Theme.of(context).textTheme.subtitle2,),
                        Text('photos',
                          style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(

                  child: InkWell(
                    child: Column(
                      children: [
                        Text('10K',
                          style: Theme.of(context).textTheme.subtitle2,),
                        Text('followers',
                          style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(

                  child: InkWell(
                    child: Column(
                      children: [
                        Text('1880',
                          style: Theme.of(context).textTheme.subtitle2,),
                        Text('followings',
                          style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                    onTap: (){},
                  ),
                ),

              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: (){},
                  child:Text ('Add Photos'),
                ),
                
              ),
              SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: (){
                  navigateTo(context, EditProfileScreen(),);
                },
                child:Icon(IconBroken.Edit,
                size: 16,),
              ),
            ],
          ),
          Row(
            children: [
              OutlinedButton(onPressed: (){
                FirebaseMessaging.instance.subscribeToTopic('announcements');
              },
                  child: Text('subscribe')),
              SizedBox(
                width: 20,
              ),

              OutlinedButton(onPressed: (){
                FirebaseMessaging.instance.unsubscribeFromTopic('announcements');

              },
                  child: Text('unSubscribe'))

            ],
          )
        ],
      ),
    );
  },
);
  }
}
