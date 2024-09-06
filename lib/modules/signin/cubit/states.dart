abstract base class SignInStates{}

final class SignInInitialState extends SignInStates{}

final class SignInLoadingState extends SignInStates{}

final class SignInPasswordVisibilityState extends SignInStates{}
final class SignInSuccessLoginState extends SignInStates{}
final class SignInLoginErrorState extends SignInStates{
  String message;
  SignInLoginErrorState(this.message);
}