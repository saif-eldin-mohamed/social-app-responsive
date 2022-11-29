import 'dart:io';
import 'package:chat/social_app/cubit_app/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../chats/chatsScreen.dart';
import '../componenet/constant.dart';
import '../feeds/feeds_screen.dart';
import '../model/messages_model.dart';
import '../model/post_model.dart';
import '../model/social_user_model.dart';
import '../new_post/newPost_screen.dart';
import '../settings/seatings_screen.dart';
import '../users/users_screen.dart';

class socialCubit extends Cubit<socialStates> {
  socialCubit() : super(socialInitialStates());
  static socialCubit get(context) => BlocProvider.of(context);
  socialUserModel? userModel;

  void getUserData() {
    emit(socialGetUserLoadingStates());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
// print(value.data());
      userModel = socialUserModel.fromJson(value.data()!);
      emit(socialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(socialGetUserErreoStates(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    feedsScreen(),
    ChatsScreen(),
    newPost(),
    usersScreen(),
    settingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
    }
      if (index == 2) {
      emit(socialNewPostState());
    } else {
      currentIndex = index;

      emit(socialChangeBottomNavState());
    }
  }

  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    XFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
    ));
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(socialProfileImagePickedSuccessState());
    } else {
      print('no image select ');
      emit(socialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    XFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
    ));
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(socialCoverImagePickedSuccessState());
    } else {
      print('no image select ');
      emit(socialCoverImagePickedErrorState());
    }
  }

  void uploadProfile({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(socialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(socialUploadProfileImageSuccessState());
        print(value);
        updateUser(phone: phone, bio: bio, name: name, image: value);
      }).catchError((error) {
        print(error);
        emit(socialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error);
      emit(socialUploadProfileImageErrorState());
    });
  }

  void uploadCover({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(socialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(socialUploadCoverImageSuccessState());
        print(value);

        updateUser(phone: phone, bio: bio, name: name, cover: value);
      }).catchError((error) {
        print(error);

        // emit(socialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error);
      emit(socialUploadCoverImageErrorState());
    });
  }

//   void updateUserImages({
//     required String name,
//     required String phone,
//     required String bio,
//   }) {
//     emit(socialUserUpdateLoadingState());
//     if (coverImage != null) {
//       uploadCover();
//     }
//     else if (profileImage != null) {
//       uploadProfile();
//     }
//     else if(coverImage != null &&profileImage != null){
//
//
//     }
//     else {
//
// updateUser(
//     name: name,
//     phone: phone,
//     bio: bio);
//     }
//   }
//

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    socialUserModel model = socialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel?.email,
      cover: cover ?? userModel?.cover,
      image: image ?? userModel?.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId!)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(socialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    XFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
    ));
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(socialCoverImagePickedSuccessState());
    } else {
      print('no image select ');
      emit(socialCoverImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(socialRemovePostImageSuccessState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(socialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(socialCreatePostSuccessState());
        print(value);
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        print(error);

        emit(socialCreatePostErrorState());
      });
    }).catchError((error) {
      print(error);
      emit(socialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(socialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel?.name,
      image: userModel?.image,
      uId: userModel?.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(socialCreatePostSuccessState());
    }).catchError((error) {
      emit(socialCreatePostErrorState());
    });
  }


  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<String> comment = [];
  List<int> comments = [];


  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          comment.add(element.id);
          comments.add(value.docs.length);
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});


      });
      emit(socialGetPostsSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(socialGetPostsErrorStates(error.toString()));
    })
    ;
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(socialLikePostsSuccessStates());
    }).catchError((error) {
      emit(socialLikePostsErrorStates(error.toString()));
    });
  }


  void addComment(String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(comment)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      'comments': true,
    }).then((value) {
      emit(socialAddCommentsSuccessStates());
    }).catchError((error) {
      emit(socialAddCommentsErrorStates(error.toString()));
    });
  }



  List<socialUserModel> users =[];

  void getAllUsers()
  {
if(users.length == 0)
  FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] != userModel!.uId)
        users.add(socialUserModel.fromJson(
            element.data()));

      });
      emit(socialGetAllUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(socialGetAllUserErrorStates(error.toString()));
    })
    ;
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    socialMessagesModel model = socialMessagesModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(socialSendMessagesSuccessStates());
    }).catchError((error) {
      emit(socialSendMessagesErrorStates(error));
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(socialSendMessagesSuccessStates());
    }).catchError((error) {
      emit(socialSendMessagesErrorStates(error));
    });
  }


  List<socialMessagesModel> messages=[];

  void getMessages({
    required String receiverId,

  }){
    FirebaseFirestore.instance.collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages=[];
      event.docs.forEach((element) {
        messages.add(socialMessagesModel.fromJson(element.data()));
      });
      emit(socialGetMessagesSuccessStates());
    });

  }
  }


