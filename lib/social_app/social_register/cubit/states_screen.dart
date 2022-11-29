
abstract  class dateTimeRegisterStates  {}

class socialRegisterInitialState extends dateTimeRegisterStates{}
class socialRegisterLoadingState extends dateTimeRegisterStates{}
class socialRegisterSuccessState extends dateTimeRegisterStates{

}
class socialRegisterErrorState extends dateTimeRegisterStates{
   final String? error;
  socialRegisterErrorState(this.error);
}
class socialRegisterChangePasswordVisibilityState extends dateTimeRegisterStates{}


class socialCreateUserSuccessState extends dateTimeRegisterStates{

}
class socialCreateUserErrorState extends dateTimeRegisterStates{
  final String? error;
  socialCreateUserErrorState(this.error);
}