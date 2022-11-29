abstract class socialStates{}
class socialInitialStates extends socialStates{}
class socialGetUserLoadingStates extends socialStates{}
class socialGetUserSuccessStates extends socialStates{}
class socialGetUserErreoStates extends socialStates{

  final String error;
  socialGetUserErreoStates(this.error);
}
class socialChangeBottomNavState extends socialStates{}
class socialNewPostState extends socialStates{}
class socialProfileImagePickedSuccessState extends socialStates{}


class socialProfileImagePickedErrorState  extends socialStates{}
class socialCoverImagePickedSuccessState extends socialStates{}
class socialCoverImagePickedErrorState  extends socialStates{}

class socialUploadProfileImageSuccessState extends socialStates{}
class socialUploadProfileImageErrorState  extends socialStates{}
class socialUploadCoverImageSuccessState extends socialStates{}
class socialUploadCoverImageErrorState  extends socialStates{}
class socialUserUpdateLoadingState  extends socialStates{}
class socialUserUpdateErrorState  extends socialStates{}

class socialCreatePostLoadingState  extends socialStates{}
class socialCreatePostErrorState  extends socialStates{}
class socialCreatePostSuccessState  extends socialStates{}

class socialPostImageSuccessState extends socialStates{}
class socialPostImageErrorState extends socialStates{}

class socialRemovePostImageSuccessState extends socialStates{}

class socialGetPostsLoadingStates extends socialStates{}
class socialGetPostsSuccessStates extends socialStates{}
class socialGetPostsErrorStates extends socialStates{

  final String error;
  socialGetPostsErrorStates(this.error);
}

class socialLikePostsSuccessStates extends socialStates{}
class socialLikePostsErrorStates extends socialStates{

  final String error;
  socialLikePostsErrorStates(this.error);
}

class socialAddCommentsSuccessStates extends socialStates{}
class socialAddCommentsErrorStates extends socialStates{

  final String error;
  socialAddCommentsErrorStates(this.error);
}


class socialGetAllUserLoadingStates extends socialStates{}
class socialGetAllUserSuccessStates extends socialStates{}
class socialGetAllUserErrorStates extends socialStates{

  final String error;
  socialGetAllUserErrorStates(this.error);
}


class socialSendMessagesSuccessStates extends socialStates{}
class socialSendMessagesErrorStates extends socialStates{

  final String error;
  socialSendMessagesErrorStates(this.error);
}
class socialGetMessagesSuccessStates extends socialStates{}
class socialGetMessagesErrorStates extends socialStates{

  final String error;
  socialGetMessagesErrorStates(this.error);
}