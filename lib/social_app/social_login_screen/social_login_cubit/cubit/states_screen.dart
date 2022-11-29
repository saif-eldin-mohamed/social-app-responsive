
abstract  class socialLoginStates  {}

class dateTimeLoginInitialState extends socialLoginStates{}
class dateTimeLogLoadingState extends socialLoginStates{}
class dateTimeLoginSuccessState extends socialLoginStates{
   final String uId;
   dateTimeLoginSuccessState (this.uId);
}
class dateTimeLoginErrorState extends socialLoginStates{
   final String? error;
   dateTimeLoginErrorState(this.error);
}
class dateTimeChangePasswordVisibilityState extends socialLoginStates{}
