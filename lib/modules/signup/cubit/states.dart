abstract base class SignUpStates{}

final class SignUpInitialState extends SignUpStates{}

final class SignUpPasswordVisibilityState extends SignUpStates{}

final class SignUpLoadingState extends SignUpStates{}

final class SignUpCreatedUserState extends SignUpStates{}

final class SignUpCreatedUserErrorState extends SignUpStates{

  final String message;
  SignUpCreatedUserErrorState(this.message);

}